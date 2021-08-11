
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

enum Action {
	case none
	case tap(NewsListPresenterProtocol?)
}
