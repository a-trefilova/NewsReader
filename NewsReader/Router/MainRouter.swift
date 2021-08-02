
import UIKit

final class MainRouter: NSObject {

    private let dataStore: DataStore
    private let window: UIWindow?
    private var navigationController: UINavigationController?

    init(window: UIWindow?, dataStore: DataStore) {
        self.window = window
        self.dataStore = dataStore
    }
    
    func setInitialViewController() {
        let newsListViewController = NewsListAssembly().assembleModule(with: self, dataStore: dataStore)
        navigationController = UINavigationController(rootViewController: newsListViewController)
        window?.rootViewController = navigationController
    }
    
    func showDetailedViewController(for id: String) {
        let detailedViewController = DetailedItemAssembly().assembleModule(params: id, with: self, dataStore: dataStore)
        navigationController?.pushViewController(detailedViewController, animated: true)
    }

    func openResource(resource: URL) {
        UIApplication.shared.open(resource, options: [:], completionHandler: { _ in })
    }
}
