import Foundation

struct ApiFailureError {
    
    init(statusCode code: StatusCode) {
        self.statusCode = code
        
        switch code {
        case .Reachability:
            customMessage ="Internet is not working or connected properly. Check for Wifi or Data connection"
            errorDescription = "Internet is not working or connected properly. Check for Wifi or Data connection"
        case .JSONParsing:
            customMessage = "Something went wrong while parsing JSON. Please check the JSON response or the object"
            errorDescription = "Something went wrong while parsing JSON. Please check the JSON response or the object"
        case .Unauthorized:
            customMessage = "Token expired, try using the refresh token or login again using credentials"
            errorDescription = "Token expired, try using the refresh token or login again using credentials"
        case .InvalidCredentials:
            customMessage = "Password or Username is wrong."
            errorDescription = "Password or Username is wrong."
        case .Timeout:
            customMessage = "Timedout."
            errorDescription = "Timedout."
        default:
            customMessage = "Something went wrong while parsing JSON. Please check the JSON response or the object"
            errorDescription = "Something went wrong while parsing JSON. Please check the JSON response or the object"      
        }
    }
    
    var errorDescription: String?
    var customMessage: String?
    var statusCode: StatusCode?
}
