
import Foundation

protocol NewsListPresenterProtocol: AnyObject {
    func didLoadView()
    func didSelectViewModel(_ viewModel: NewsItemViewModel)
    func didLoadCell(at indexPath: IndexPath, viewModelId: String)
}

final class NewsListPresenter: NewsListPresenterProtocol {

    private let interactor: NewsListInteractorProtocol?
    private weak var view: NewsListViewProtocol?
    private let router: NewsListRouterProtocol

	init(interactor: NewsListInteractorProtocol, view: NewsListViewProtocol, router: NewsListRouterProtocol) {
		self.interactor = interactor
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

	func didSelectViewModel(_ viewModel: NewsItemViewModel) {
		router.showDetailedViewController(viewModel)
    }

	func didLoadCell(at indexPath: IndexPath, viewModelId: String) {
		interactor?.getImage(viewModelId: viewModelId) { image in
			DispatchQueue.main.async { self.view?.updateCell(at: indexPath, with: image) }
		}
	}
}
