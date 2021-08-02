
import UIKit

final class DetailedItemAssembly: AssemblyProtocol {
    func assembleModule(params: String?, with mainRouter: MainRouter, dataStore: DataStore) -> UIViewController {
        guard let id = params else { return UIViewController() }
        let view = DetailedItemViewController()
        let moduleRouter = DetailedItemRouter(rootView: view, mainRouter: mainRouter)
        let presenter = DetailedItemPresenter(view: view, router: moduleRouter, viewModelId: id)
        let uploadImageService = UploadImageService(cache: dataStore.cache)
        let interactor = DetailedItemInteractor(presenter: presenter,
                                                dataStore: dataStore,
                                                uploadImageService: uploadImageService,
                                                dataObjectId: id)

        view.presenter = presenter
        presenter.interactor = interactor

        return view
    }

}
