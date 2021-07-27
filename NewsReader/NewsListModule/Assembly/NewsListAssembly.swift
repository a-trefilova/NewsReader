
import UIKit

final class NewsListAssembly {
    
    func assembleNewsListModule(with router: NewsReaderRouter) -> UIViewController {
        let view = NewsListVC()
        let presenter = NewsListPresenter(view: view)
        let interactor = NewsListInteractor(presenter: presenter)
        
        view.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        
        return view
    }
}
