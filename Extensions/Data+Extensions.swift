import Foundation


extension Data {
    
    // Converts JSON data to specified object
    func toObject<T : Decodable>(ofType type: T.Type) throws -> T {
        return  try JSONDecoder().decode(T.self, from: self)
    }
}
