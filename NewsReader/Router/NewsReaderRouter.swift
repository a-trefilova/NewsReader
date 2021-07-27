
import UIKit

class NewsReaderRouter: NSObject {
    
    var navigationController: UINavigationController?
    var window: UIWindow?
    weak var viewController: NewsListVC!
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func setInitialViewController() {
        let newsListViewController = NewsListAssembly().assembleNewsListModule(with: self)
        navigationController = UINavigationController(rootViewController: newsListViewController)
        window?.rootViewController = navigationController
    }
    
    func showDetailedViewController(newsItem: NewsItem) {
        let detailedViewController = DetailedItemAssembly().assembleDetailedItemModule(newsItem: newsItem)
        navigationController?.pushViewController(detailedViewController, animated: true)
    }
}
