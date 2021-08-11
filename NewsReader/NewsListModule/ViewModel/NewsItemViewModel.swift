
import Foundation

struct NewsItemViewModel {
    let id: String
    let title: String
    let description: String
    let date: String
    let image: Image
	let urlString: String
	let authorName: String?

	func wasSelected(router: NewsListRouterProtocol) {
		router.showDetailedViewController(self)
	}
}
