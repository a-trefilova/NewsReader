
import Foundation

struct NewsItemViewModel {
    let id: String
    let title: String
    let description: String
    let date: String
    let image: Image
	let urlString: String
	let authorName: String?
	var action: Action = .none {
		didSet {
			switch action {
			case .tap(let presenter):
				presenter?.didSelectViewModel(self)
			default:
				break
			}
		}
	}
}

extension NewsItemViewModel: Equatable {
	static func == (lhs: NewsItemViewModel, rhs: NewsItemViewModel) -> Bool {
		if lhs.id == rhs.id &&
			lhs.title == rhs.title &&
			lhs.description == rhs.description &&
			lhs.date == rhs.date &&
			lhs.urlString == rhs.urlString &&
			lhs.authorName == rhs.authorName {
			return true
		} else {
			return false
		}
	}
}

enum Action {
	case none
	case tap(NewsListPresenterProtocol?)
}
