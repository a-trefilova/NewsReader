
import UIKit

protocol MainRouterProtocol {
	func setInitialViewController()
	func showDetailedViewController(_ newsItemViewModel: NewsItemViewModel)
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
    
    func showDetailedViewController(_ newsItemViewModel: NewsItemViewModel) {
		let detailedViewController = DetailedItemAssembly().assembleModule(newsItemViewModel: newsItemViewModel,
																		   with: self,
																		   dataStore: dataStore)
        navigationController?.pushViewController(detailedViewController, animated: true)
    }

    func openResource(resource: URL) {
        UIApplication.shared.open(resource, options: [:])
    }
}
