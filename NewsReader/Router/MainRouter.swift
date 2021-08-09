
import UIKit

protocol MainRouterProtocol {
	func setInitialViewController()
	func showDetailedViewController(for newsItemId: String)
	func openResource(resource: URL)
}

final class MainRouter: NSObject, MainRouterProtocol {

    private let dataStore: DataStoreProtocol
    private let window: UIWindow?
    private var navigationController: UINavigationController?

    init(window: UIWindow?, dataStore: DataStoreProtocol) {
        self.window = window
        self.dataStore = dataStore
    }
    
    func setInitialViewController() {
        let newsListViewController = NewsListAssembly().assembleModule(with: self, dataStore: dataStore)
        navigationController = UINavigationController(rootViewController: newsListViewController)
        window?.rootViewController = navigationController
    }
    
    func showDetailedViewController(for newsItemId: String) {
        let detailedViewController = DetailedItemAssembly().assembleModule(newsItemId: newsItemId, with: self, dataStore: dataStore)
        navigationController?.pushViewController(detailedViewController, animated: true)
    }

    func openResource(resource: URL) {
        UIApplication.shared.open(resource, options: [:])
    }
}
