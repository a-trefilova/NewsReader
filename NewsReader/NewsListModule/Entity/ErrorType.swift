
import Foundation

enum ErrorType: Error {
    case parsingFailure(String)
    case connectionFailure(String)
    case invalidEntryPoint(String)
	var description: String {
		switch self {
		case .parsingFailure(let message):
			return message
		case .connectionFailure(let message):
			return message
		case .invalidEntryPoint(let message):
			return message
		}
	}
}
