
import UIKit

final class DetailedItemAssembly: AssemblyProtocol {
    func assembleModule(newsItemId: String?, with mainRouter: MainRouter, dataStore: DataStore) -> UIViewController {
        guard let id = newsItemId else { return UIViewController() }
        let view = DetailedItemViewController()
        let moduleRouter = DetailedItemRouter(rootView: view, mainRouter: mainRouter)
        let presenter = DetailedItemPresenter(view: view, router: moduleRouter, viewModelId: id)
        let uploadImageService = UploadImageService(cache: dataStore.cache)
		let urlValidationService = URLValidationService(urlString: dataStore.dataTransferObjects.first(where: {$0.id == newsItemId})?.link)
		let viewModelFactory = ViewModelFactory()
        let interactor = DetailedItemInteractor(presenter: presenter,
                                                dataStore: dataStore,
												uploadImageService: uploadImageService,
												urlValidationService: urlValidationService,
												viewModelFactory: viewModelFactory,
                                                dataObjectId: id)

        view.presenter = presenter
        presenter.interactor = interactor

        return view
    }

}
