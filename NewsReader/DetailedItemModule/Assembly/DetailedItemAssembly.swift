
import UIKit

final class DetailedItemAssembly {
    func assembleDetailedItemModule(id: String, mainRouter: MainRouter, dataStore: DataStore) -> UIViewController {
        let view = DetailedItemViewController()
        let moduleRouter = DetailedItemRouter(rootView: view, mainRouter: mainRouter)
        let presenter = DetailedItemPresenter(view: view, router: moduleRouter, id: id)
        let uploadImageService = UploadImageService(cache: dataStore.cache)
        let interactor = DetailedItemInteractor(presenter: presenter,
                                                dataStore: dataStore,
                                                uploadImageService: uploadImageService,
                                                id: id)
       
        view.presenter = presenter
        presenter.interactor = interactor
        
        return view
    }
}
