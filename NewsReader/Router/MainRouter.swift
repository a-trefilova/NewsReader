
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
        let newsListViewController = NewsListAssembly().assembleNewsListModule(with: self, dataStore: dataStore)
        navigationController = UINavigationController(rootViewController: newsListViewController)
        window?.rootViewController = navigationController
    }
    
    func showDetailedViewController(for id: String) {
        let detailedViewController = DetailedItemAssembly().assembleDetailedItemModule(id: id, mainRouter: self, dataStore: dataStore)
        navigationController?.pushViewController(detailedViewController, animated: true)
    }
}

class DataStore {
    let cache: NSCache<NSString, UIImage> = NSCache<NSString, UIImage>()
    private(set) var dataTransferObjects: [NewsItemDTO] = []

    func saveData(data: [NewsItemDTO]) {
        self.dataTransferObjects = data
    }
}
