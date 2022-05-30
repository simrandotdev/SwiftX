import Foundation

struct ApiFailureError {
    
    init(statusCode code: StatusCode) {
        self.statusCode = code
        
        switch code {
        case .Reachability:
            customMessage = "Internet is not working or connected properly. Check for Wifi or Data connection."
            errorDescription = "Internet is not working or connected properly. Check for Wifi or Data connection."
        case .JSONParsing:
            customMessage = "Something went wrong while parsing response. Please check the response."
            errorDescription = "Something went wrong while parsing response. Please check the response."
        case .Unauthorized:
            customMessage = "Session expired, please try logging in again."
            errorDescription = "Token expired, try using the refresh token or login again using credentials."
        case .InvalidCredentials:
            customMessage = "Password or Username is wrong."
            errorDescription = "Password or Username is wrong."
        case .Timeout:
            customMessage = "Request Timedout."
            errorDescription = "Request Timedout."
        default:
            customMessage = "Something went wrong. Please try again."
            errorDescription = "Something went wrong. Please try again."      
        }
    }
    
    var errorDescription: String?
    var customMessage: String?
    var statusCode: StatusCode?
}
