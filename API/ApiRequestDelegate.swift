import Foundation

protocol ApiRequestDelegate {
    func GET<T : Decodable>(type: T.Type,
                            forURL url: String,
                            withHeader headers:[String: String],
                            onComplete completionHandler: @escaping(T?, ApiFailureError?) -> Void)
    
    func POST<T : Decodable>(type: T.Type, forURL url: String,
              withBody bodyParams: [String : String],
              andHeader headers: [String: String],
              onComplete completionHandler: @escaping(T?, ApiFailureError?) -> Void)
    
    func PATCH<T : Decodable>(type: T.Type, forURL url: String,
                              withBody bodyParams: [String : String],
                              andHeader headers: [String: String],
                              onComplete completionHandler: @escaping(T?, ApiFailureError?) -> Void)
    
    func PUT<T : Decodable>(type: T.Type, forURL url: String,
                              withBody bodyParams: [String : Any],
                              andHeader headers: [String: String],
                              onComplete completionHandler: @escaping(T?, ApiFailureError?) -> Void)
}
