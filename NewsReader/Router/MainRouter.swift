
import UIKit

class MainRouter: NSObject {

    var dataStore: DataStore
    var navigationController: UINavigationController?
    var window: UIWindow?
    
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

class DataStore {
    let cache: NSCache<NSString, UIImage> = NSCache<NSString, UIImage>()
    private(set) var dataTransferObjects: [NewsItemDTO] = []

    func saveData(data: [NewsItemDTO]) {
        self.dataTransferObjects = data
    }
}
