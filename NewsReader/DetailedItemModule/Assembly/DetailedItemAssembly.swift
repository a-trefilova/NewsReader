
import UIKit

final class DetailedItemAssembly {
    func assembleDetailedItemModule(newsItem: NewsItem, mainRouter: MainRouter) -> UIViewController {
        let view = DetailedItemViewController()
        let moduleRouter = DetailedItemRouter(rootView: view, mainRouter: mainRouter)
        let presenter = DetailedItemPresenter(view: view, router: moduleRouter, newsItem: newsItem)
        let interactor = DetailedItemInteractor(presenter: presenter)
       
        view.presenter = presenter
        presenter.interactor = interactor
        
        return view
    }
}
