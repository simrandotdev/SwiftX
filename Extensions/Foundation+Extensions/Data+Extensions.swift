import Foundation


extension Data {
    
    // Converts JSON data to specified object
    func toObject<T : Decodable>(ofType type: T.Type) throws -> T {
        return  try JSONDecoder().decode(T.self, from: self)
    }

    func toObject<T : Decodable>(toType type: T.Type,
                                     dateDecodingStrategy: JSONDecoder.DateDecodingStrategy? = nil,
                                     keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy? = nil) throws -> T {
        let decoder = JSONDecoder()
        
        if let dateDecodingStrategy = dateDecodingStrategy {
            decoder.dateDecodingStrategy = dateDecodingStrategy
        }
        
        if let keyDecodingStrategy = keyDecodingStrategy {
            decoder.keyDecodingStrategy = keyDecodingStrategy
        }
        
        return  try decoder.decode(T.self, from: self)
    }
}
