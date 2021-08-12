
import UIKit

protocol DetailedItemAssemblyProtocol {
	func assembleModule(newsItemViewModel: NewsItemViewModel, with mainRouter: MainRouterProtocol, dataStore: DataStoreProtocol) -> UIViewController
}

final class DetailedItemAssembly: DetailedItemAssemblyProtocol {
    func assembleModule(newsItemViewModel: NewsItemViewModel, with mainRouter: MainRouterProtocol, dataStore: DataStoreProtocol) -> UIViewController {
        let view = DetailedItemViewController()
        let moduleRouter = DetailedItemRouter(rootView: view, mainRouter: mainRouter)
		let uploadImageService = UploadImageService(cache: dataStore.cache)
		let urlValidationService = URLValidationService(urlString: newsItemViewModel.urlString)
		let interactor = DetailedItemInteractor(dataStore: dataStore,
												uploadImageService: uploadImageService,
												urlValidationService: urlValidationService)
		let presenter = DetailedItemPresenter(interactor: interactor,
											  view: view,
											  router: moduleRouter,
											  viewModel: newsItemViewModel)
        view.presenter = presenter
        return view
    }

}
