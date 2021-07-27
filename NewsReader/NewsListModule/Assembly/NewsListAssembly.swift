
import UIKit

class NewsListAssembly {
    
    func assembleNewsListModule() -> UIViewController {
        let view = NewsListVC()
        let presenter = NewsListPresenter(view: view)
        let interactor = NewsListInteractor(presenter: presenter)
        let router = NewsReaderRouter(viewController: view)
        
        view.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        
        let navigationController = UINavigationController(rootViewController: view)
        return navigationController
    }
}
