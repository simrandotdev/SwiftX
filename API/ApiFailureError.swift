import Foundation

struct CompanionError {
    
    var title: String
    var message: String
    var errorMessage: String
    
    init(error: APIErrors) {
        title = "Error"
        message = "Something went wrong, please try again."
        switch(error) {
        
        case .invalidResponse(let description):
            errorMessage = description
        case .invalidRequestWithIncorrectUrlFormat(let description):
            errorMessage = description
        case .badRequest(let description):
            errorMessage = description
        case .invalidUrl(let description):
            errorMessage = description
        case .unauthorized(let description):
            message = "You are not authorized to access this resource."
            errorMessage = description
        case .failedToParseJSON(let description):
            errorMessage = description
        case .unknown(let description):
            errorMessage = description
        }
        
        print("❌", errorMessage)
    }
}
