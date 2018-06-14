import Foundation

struct ApiFailureError {
    
    init(statusCode code: StatusCode) {
        self.statusCode = code
        
        switch code {
        case .Reachability:
            customMessage = NSLocalizedString(Constants.LocalizedStringKeys.INTERNET_CONNECTION_ERROR,
                                              comment: Constants.LocalizedStringKeys.INTERNET_CONNECTION_ERROR)
            errorDescription = "Internet is not working or connected properly. Check for Wifi or Data connection"
        case .JSONParsing:
            customMessage = NSLocalizedString(Constants.LocalizedStringKeys.SOMETHING_WENT_WRONG_MESSAGE,
                                              comment: Constants.LocalizedStringKeys.SOMETHING_WENT_WRONG_MESSAGE)
            errorDescription = "Something went wrong while parsing JSON. Please check the JSON response or the object"
        case .Unauthorized:
            customMessage = NSLocalizedString(Constants.LocalizedStringKeys.SESSION_EXPIRED,
                                              comment: Constants.LocalizedStringKeys.SESSION_EXPIRED)
            errorDescription = "Token expired, try using the refresh token or login again using credentials"
        case .InvalidCredentials:
            customMessage = NSLocalizedString(Constants.LocalizedStringKeys.WRONG_CREDENTIALS,
                                              comment: Constants.LocalizedStringKeys.WRONG_CREDENTIALS)
            errorDescription = "Password or Username is wrong."
        case .Timeout:
            customMessage = NSLocalizedString(Constants.LocalizedStringKeys.SOMETHING_WENT_WRONG_MESSAGE,
                                              comment: Constants.LocalizedStringKeys.SOMETHING_WENT_WRONG_MESSAGE)
            errorDescription = "Timedout."
        default:
            customMessage = NSLocalizedString(Constants.LocalizedStringKeys.SOMETHING_WENT_WRONG_MESSAGE,
                                              comment: Constants.LocalizedStringKeys.SOMETHING_WENT_WRONG_MESSAGE)
            errorDescription = "Something went wrong while parsing JSON. Please check the JSON response or the object"      
        }
    }
    
    var errorDescription: String?
    var customMessage: String?
    var statusCode: StatusCode?
}
