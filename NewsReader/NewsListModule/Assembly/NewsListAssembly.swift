
import UIKit

protocol NewsListAssemblyProtocol {
    func assembleModule(with mainRouter: MainRouterProtocol, dataStore: DataStoreProtocol) -> UIViewController
}

final class NewsListAssembly: NewsListAssemblyProtocol {
    func assembleModule(with mainRouter: MainRouterProtocol, dataStore: DataStoreProtocol) -> UIViewController {
        let view = NewsListViewController()
        let newsListService = NewsListService()
        let uploadImageService = UploadImageService(cache: dataStore.cache)
		let viewModelFactory = ViewModelFactory()
        let moduleRouter = NewsListRouter(rootView: view, mainRouter: mainRouter)
		let interactor = NewsListInteractor(newsListService: newsListService,
											uploadImageService: uploadImageService,
											dataStore: dataStore,
											viewModelFactory: viewModelFactory)
		let presenter = NewsListPresenter(interactor: interactor,
										  view: view,
										  router: moduleRouter)
        view.presenter = presenter

        return view
    }

}
