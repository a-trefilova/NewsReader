
import UIKit

class NewsReaderRouter: NSObject {
    
    var navigationController: UINavigationController?
    var window: UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func setInitialViewController() {
        let newsListViewController = NewsListAssembly().assembleNewsListModule(with: self)
        navigationController = UINavigationController(rootViewController: newsListViewController)
        window?.rootViewController = navigationController
    }
    
    func showDetailedViewController(for newsItem: NewsItem) {
        let detailedViewController = DetailedItemAssembly().assembleDetailedItemModule(newsItem: newsItem)
        navigationController?.pushViewController(detailedViewController, animated: true)
    }
}
