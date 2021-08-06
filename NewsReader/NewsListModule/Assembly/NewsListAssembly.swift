
import UIKit

protocol AssemblyProtocol {
    func assembleModule(newsItemId: String?, with mainRouter: MainRouter, dataStore: DataStore) -> UIViewController
}

final class NewsListAssembly: AssemblyProtocol {
    func assembleModule(newsItemId: String? = "", with mainRouter: MainRouter, dataStore: DataStore) -> UIViewController {
        let view = NewsListViewController()
        let newsListService = NewsListService()
        let uploadImageService = UploadImageService(cache: dataStore.cache)
		let viewModelFactory = ViewModelFactory()
        let moduleRouter = NewsListRouter(rootView: view, mainRouter: mainRouter)
        let presenter = NewsListPresenter(view: view, router: moduleRouter)
        let interactor = NewsListInteractor(presenter: presenter,
                                            newsListService: newsListService,
                                            uploadImageService: uploadImageService,
											dataStore: dataStore,
											viewModelFactory: viewModelFactory)

        view.presenter = presenter
        presenter.interactor = interactor

        return view
    }

}
