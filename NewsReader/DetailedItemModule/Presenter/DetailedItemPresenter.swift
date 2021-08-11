
import Foundation

protocol DetailedItemPresenterProtocol: AnyObject {
	var interactor: DetailedItemInteractorProtocol? { get set }
    func didLoadView()
    func didTapOnOpenResource()
}

final class DetailedItemPresenter: DetailedItemPresenterProtocol {

	var interactor: DetailedItemInteractorProtocol?
	private let viewModel: NewsItemViewModel
	private let router: DetailedItemRouterProtocol
	private weak var view: DetaildItemViewProtocol?

	init(view: DetaildItemViewProtocol, router: DetailedItemRouterProtocol, viewModel: NewsItemViewModel) {
		self.view = view
		self.router = router
		self.viewModel = viewModel
	}

	func didLoadView() {
		self.view?.render(viewModel: viewModel)
	}

	func didTapOnOpenResource() {
		interactor?.validateUrl(completion: { [weak self] result in
			guard let self = self else { return }
			switch result {
			case .success(let validUrl):
				DispatchQueue.main.async { self.router.showSafariLink(validUrl: validUrl) }
			case .failure(let error):
				DispatchQueue.main.async { self.router.showErrorMessage(error.description) }
			}
		})
	}
}

