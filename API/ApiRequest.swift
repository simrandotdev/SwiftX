import Alamofire
import Foundation

/*
 STATUS CODES
 -1  : JSON parsing error
  0  : Reachability
 200 : OK
 401 : Token expired
 403 : Wrong Password or Username
 */

class ApiRequest : ApiRequestDelegate {
    
    private let reachability = Reachability()
    
    func GET<T : Decodable>(type: T.Type,
                            forURL url: String,
                            withHeader headers:[String: String],
                            onComplete completionHandler: @escaping(T?, ApiFailureError?) -> Void) {
        if !(reachability?.isReachable ?? false) {
            let error = ApiFailureError(statusCode: .Reachability)
            completionHandler(nil, error)
        } else {
            
            Alamofire.request(url,
                              method: .get,
                              parameters: [:],
                              headers: createHeader(headerDict: headers))
                    .response { (response) in                        
                        if response.response?.statusCode == 200 {
                        guard let data = response.data else { return }
                        do {
                            let item = try data.fromJsonData(to: T.self)
                            completionHandler(item, nil)
                        } catch {
                            let apiFailureError = ApiFailureError(statusCode: .JSONParsing)
                            completionHandler(nil, apiFailureError)
                        }
                    } else {
                            if let statusCode = response.response?.statusCode,
                                let sc = StatusCode(rawValue: (statusCode)) {
                                let apiFailureError = ApiFailureError(statusCode: sc)
                                completionHandler(nil, apiFailureError)
                            } else {
                                let apiFailureError = ApiFailureError(statusCode: .Unauthorized)
                                completionHandler(nil, apiFailureError)
                            }
                    }
            }
        }
    }
    
    
    func POST<T>(type: T.Type,
                 forURL url: String,
                 withBody bodyParams: [String : String],
                 andHeader headers: [String : String],
                 onComplete completionHandler: @escaping (T?, ApiFailureError?) -> Void) where T : Decodable {
        if !(reachability?.isReachable ?? false) {
            let error = ApiFailureError(statusCode: .Reachability)
            completionHandler(nil, error)
        } else {
            let manager = Alamofire.SessionManager.default
            manager.session.configuration.timeoutIntervalForRequest = 8.00
            manager.session.configuration.timeoutIntervalForResource = 8.00
            
            manager.request(url,
                              method: .post,
                              parameters: bodyParams,
                              encoding: JSONEncoding.default,
                              headers: createHeader(headerDict: headers))
                    .response { (response) in
                        let statusCode = response.response?.statusCode
                        if statusCode == 200 {
                            guard let data = response.data else { return }

                            do {
                                let item = try data.fromJsonData(to: T.self)
                                completionHandler(item, nil)
                            } catch {
                                let apiFailureError = ApiFailureError(statusCode: .JSONParsing)
                                completionHandler(nil, apiFailureError)
                            }
                        } else {
                            guard let sc = response.response?.statusCode,
                            let statusCode = StatusCode(rawValue: sc) else {
                                let apiFailureError = ApiFailureError(statusCode: .SomethingElse)
                                completionHandler(nil, apiFailureError)
                                return
                            }
                            let apiFailureError = ApiFailureError(statusCode: statusCode)
                            completionHandler(nil, apiFailureError)
                        }
            }
        }
    }
    
    func PATCH<T>(type: T.Type, forURL url: String, withBody bodyParams: [String : String], andHeader headers: [String : String], onComplete completionHandler: @escaping (T?, ApiFailureError?) -> Void) where T : Decodable {
        if !(reachability?.isReachable ?? false) {
            let error = ApiFailureError(statusCode: .Reachability)
            completionHandler(nil, error)
        } else {
            let manager = Alamofire.SessionManager.default
            manager.session.configuration.timeoutIntervalForRequest = 8.00
            manager.session.configuration.timeoutIntervalForResource = 8.00
            
            manager.request(url,
                            method: .patch,
                            parameters: bodyParams,
                            encoding: JSONEncoding.default,
                            headers: createHeader(headerDict: headers))
                .response { (response) in
                    let statusCode = response.response?.statusCode
                    if statusCode == 200 {
                        guard let data = response.data else { return }
                        
                        do {
                            let item = try data.fromJsonData(to: T.self)
                            completionHandler(item, nil)
                        } catch {
                            let apiFailureError = ApiFailureError(statusCode: .JSONParsing)
                            completionHandler(nil, apiFailureError)
                        }
                    } else {
                        guard let sc = response.response?.statusCode,
                            let statusCode = StatusCode(rawValue: sc) else {
                                let apiFailureError = ApiFailureError(statusCode: .SomethingElse)
                                completionHandler(nil, apiFailureError)
                                return
                        }
                        let apiFailureError = ApiFailureError(statusCode: statusCode)
                        completionHandler(nil, apiFailureError)
                    }
            }
        }
    }
    
    func PUT<T>(type: T.Type,
                 forURL url: String,
                 withBody bodyParams: [String : Any],
                 andHeader headers: [String : String],
                 onComplete completionHandler: @escaping (T?, ApiFailureError?) -> Void) where T : Decodable {
        if !(reachability?.isReachable ?? false) {
            let error = ApiFailureError(statusCode: .Reachability)
            completionHandler(nil, error)
        } else {
            let manager = Alamofire.SessionManager.default
            
            manager.request(url,
                            method: .put,
                            parameters: bodyParams,
                            encoding: JSONEncoding.default,
                            headers: createHeader(headerDict: headers))
                .response { (response) in
                    let statusCode = response.response?.statusCode
                    if statusCode == 200 {
                        guard let data = response.data else { return }
                        
                        do {
                            let item = try data.fromJsonData(to: T.self)
                            completionHandler(item, nil)
                        } catch {
                            let apiFailureError = ApiFailureError(statusCode: .JSONParsing)
                            completionHandler(nil, apiFailureError)
                        }
                    } else {
                        guard let sc = response.response?.statusCode,
                            let statusCode = StatusCode(rawValue: sc) else {
                                let apiFailureError = ApiFailureError(statusCode: .SomethingElse)
                                completionHandler(nil, apiFailureError)
                                return
                        }
                        let apiFailureError = ApiFailureError(statusCode: statusCode)
                        completionHandler(nil, apiFailureError)
                    }
            }
        }
    }
    
    private func createHeader(headerDict: [String : String]) -> HTTPHeaders {
        var httpHeader = HTTPHeaders()
        
        headerDict.keys.forEach { (key) in
            httpHeader[key] = headerDict[key]
        }
        return httpHeader
    }
}
