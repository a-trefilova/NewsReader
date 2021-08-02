
import Foundation

enum ErrorType: Error {
    case parsingFailure(String)
    case connectionFailure(String)
    case invalidEntryPoint(String)
}
