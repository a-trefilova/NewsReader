
import UIKit

final class NewsListAssembly {
    
    func assembleNewsListModule(with mainRouter: MainRouter, dataStore: DataStore) -> UIViewController {
        let view = NewsListViewController()
        let service = NewsListService()
        let moduleRouter = NewsListRouter(rootView: view, mainRouter: mainRouter)
        let presenter = NewsListPresenter(view: view, router: moduleRouter)
        let interactor = NewsListInteractor(presenter: presenter, service: service, dataStore: dataStore)
        
        view.presenter = presenter
        presenter.interactor = interactor
        
        return view
    }
}
