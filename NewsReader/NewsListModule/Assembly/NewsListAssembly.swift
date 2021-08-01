
import UIKit

final class NewsListAssembly {
    
    func assembleNewsListModule(with mainRouter: MainRouter, dataStore: DataStore) -> UIViewController {
        let view = NewsListViewController()
        let newsListService = NewsListService()
        let uploadImageService = UploadImageService(cache: dataStore.cache)
        let moduleRouter = NewsListRouter(rootView: view, mainRouter: mainRouter)
        let presenter = NewsListPresenter(view: view, router: moduleRouter)
        let interactor = NewsListInteractor(presenter: presenter,
                                            newsListService: newsListService,
                                            uploadImageService: uploadImageService,
                                            dataStore: dataStore)
        
        view.presenter = presenter
        presenter.interactor = interactor
        
        return view
    }
}
