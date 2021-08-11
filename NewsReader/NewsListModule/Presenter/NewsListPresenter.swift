
import Foundation

protocol NewsListPresenterProtocol: AnyObject {
	var interactor: NewsListInteractorProtocol? { get set }
    func didLoadView()
    func didSelectViewModel(completion: ((NewsListRouterProtocol) -> Void)) 
    func didLoadCell(at indexPath: IndexPath, viewModelId: String)
}

final class NewsListPresenter: NewsListPresenterProtocol {

    var interactor: NewsListInteractorProtocol?
    private weak var view: NewsListViewProtocol?
    private let router: NewsListRouterProtocol

    init(view: NewsListViewProtocol, router: NewsListRouterProtocol) {
        self.view = view
        self.router = router
    }
   
    func didLoadView() {
        interactor?.getListOfItems { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let items):
                DispatchQueue.main.async { self.view?.showListOfViewModels(viewModels: items)}
            case .failure(let error):
				DispatchQueue.main.async { self.router.showErrorMessage(error.description) }
            }
        }
    }

	func didSelectViewModel(completion: ((NewsListRouterProtocol) -> Void)) {
       completion(router)
    }

	func didLoadCell(at indexPath: IndexPath, viewModelId: String) {
		interactor?.getImage(viewModelId: viewModelId) { image in
			DispatchQueue.main.async { self.view?.updateCell(at: indexPath, with: image) }
		}
	}
}
