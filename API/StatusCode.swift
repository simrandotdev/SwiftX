import Foundation
import Alamofire

enum StatusCode : Int{
    case Timeout = -1001
    case JSONParsing = -1
    case Reachability = 0
    case OK = 200
    case Unauthorized = 401
    case InvalidCredentials = 403
    case SomethingElse
}
