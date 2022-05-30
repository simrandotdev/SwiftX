import Foundation

extension String {
    // Converts the JSON string to specified Model object
    func fromJsonString<T : Decodable>(to type: T.Type) throws -> T {
        guard let jsonData = self.data(using: .utf8) else { return T.self as! T }
        return try JSONDecoder().decode(T.self, from: jsonData)
    }
    
    func isValidEmail() -> Bool {
        let emailRegEx = "(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"+"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"+"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"+"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"+"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"+"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"+"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        
        let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    func isOfLength(length: Int) -> Bool {
        return self.count == length
    }
    
    func isOfLengthOrGreater(length : Int) -> Bool {
        return self.count >= length
    }
    
    func isOfLengthOrSmaller(length: Int)-> Bool {
        return self.count <= length
    }
    
    func leftAndRightTrim() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func toDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SZ"
        let date = dateFormatter.date(from: self) ?? Date()
        return date
    }
    
    func removingWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
}
