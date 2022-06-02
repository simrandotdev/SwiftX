import Foundation

public class NetworkingClient {
    
    private var session: URLSession
    private var dateDecodingStrategy: JSONDecoder.DateDecodingStrategy
    
    init(session: URLSession = URLSession.shared,
         dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .iso8601) {
        
        self.session = session
        self.dateDecodingStrategy = dateDecodingStrategy
    }
    
    public func makeRequest<ResponseType: Decodable>(
        type: ResponseType.Type,
        withMethod method: APIHttpMethod,
        url: URL,
        body: [String : String]? = nil,
        queryParameters: [String : String]? = nil,
        headers: [String : String]? = nil) async throws -> ResponseType {
            
            guard let completeUrl = makeUrlComponents(withUrl: url, queryParameters: queryParameters)?.url else {
                throw APIErrors.invalidRequestWithIncorrectUrlFormat(
                    "Failed to create url with the passed query parameters of \(String(describing: queryParameters))"
                )
            }
            
            let request = makeUrlRequest(withMethod: method,
                                         url: completeUrl,
                                         body: body,
                                         queryParameters: queryParameters,
                                         headers: headers)
            let response = try await data(for: request)
            return try parseResponse(type: type, response: response)
            
        }
    
    
    private func parseResponse<ResponseType: Decodable>(type: ResponseType.Type,
                                                         response: APIHttpResponse) throws -> ResponseType {
        switch response.statusCode {
        case 200..<300:
            do {
                return try converData(toType: type,
                                      data: response.data,
                                      dateDecodingStrategy: dateDecodingStrategy)
            } catch {
                throw APIErrors.failedToParseJSON(error.localizedDescription)
            }
        case 400:
            throw APIErrors.badRequest("Bad request with status code: \(response.statusCode)")
        default:
            throw APIErrors.unknown("Failed to parse response with status code: \(response.statusCode) ")
        }
        
    }
    
    private func makeUrlComponents(withUrl url: URL, queryParameters: [String : String]? = nil) -> URLComponents? {
        
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        queryParameters?.forEach { urlComponents?.queryItems?.append(URLQueryItem(name: $0, value: $1)) }
        return urlComponents
        
    }
    
    private func makeUrlRequest(withMethod method: APIHttpMethod,
                                url: URL,
                                body: [String : String]? = nil,
                                queryParameters: [String : String]? = nil,
                                headers: [String : String]? = nil) -> URLRequest {
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        
        if  (method == .POST || method == .PUT || method == .PATCH),
            let body = body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
        }
        return request
        
    }
    
    private func data(for request: URLRequest) async throws -> APIHttpResponse {
        
        let (data, response) = try await session.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIErrors.invalidResponse("Failed to convert response to HTTPURLResponse")
        }
        return APIHttpResponse(data: data, response: httpResponse)
        
    }
    
    private func converData<T : Decodable>(toType type: T.Type,
                                           data: Data,
                                           dateDecodingStrategy: JSONDecoder.DateDecodingStrategy? = nil,
                                           keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy? = nil) throws -> T {
        let decoder = JSONDecoder()
        
        if let dateDecodingStrategy = dateDecodingStrategy {
            decoder.dateDecodingStrategy = dateDecodingStrategy
        }
        
        if let keyDecodingStrategy = keyDecodingStrategy {
            decoder.keyDecodingStrategy = keyDecodingStrategy
        }
        
        return  try decoder.decode(T.self, from: data)
    }
    
}


public struct APIHttpResponse {
    let data: Data
    let response: HTTPURLResponse
    var statusCode: Int {
        return response.statusCode
    }
    
    var debugString: String {
        let result = String(data: data, encoding: .utf8)
        return "Status Code: \(statusCode) - \(result ?? "<some-wrong>"))"
    }
}

public enum APIHttpMethod: String {
    case GET
    case POST
    case PUT
    case PATCH
    case DELETE
}


public enum APIErrors: Error {
    case invalidResponse(String)
    case invalidRequestWithIncorrectUrlFormat(String)
    case badRequest(String)
    case invalidUrl(String)
    case unauthorized(String)
    case failedToParseJSON(String)
    case unknown(String)
}
