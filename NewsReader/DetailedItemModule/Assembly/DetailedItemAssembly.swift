
import UIKit

protocol DetailedItemAssemblyProtocol {
	func assembleModule(newsItemViewModel: NewsItemViewModel, with mainRouter: MainRouterProtocol, dataStore: DataStoreProtocol) -> UIViewController
}

final class DetailedItemAssembly: DetailedItemAssemblyProtocol {
    func assembleModule(newsItemViewModel: NewsItemViewModel, with mainRouter: MainRouterProtocol, dataStore: DataStoreProtocol) -> UIViewController {
        let view = DetailedItemViewController()
        let moduleRouter = DetailedItemRouter(rootView: view, mainRouter: mainRouter)
		let presenter = DetailedItemPresenter(view: view, router: moduleRouter, viewModel: newsItemViewModel)
        let uploadImageService = UploadImageService(cache: dataStore.cache)
		let urlValidationService = URLValidationService(urlString: newsItemViewModel.urlString)
        let interactor = DetailedItemInteractor(presenter: presenter,
                                                dataStore: dataStore,
												uploadImageService: uploadImageService,
												urlValidationService: urlValidationService)

        view.presenter = presenter
        presenter.interactor = interactor

        return view
    }

}
