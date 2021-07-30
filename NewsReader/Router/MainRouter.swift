
import UIKit

class MainRouter: NSObject {
    
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
        let detailedViewController = DetailedItemAssembly().assembleDetailedItemModule(newsItem: newsItem, mainRouter: self)
        navigationController?.pushViewController(detailedViewController, animated: true)
    }
}
