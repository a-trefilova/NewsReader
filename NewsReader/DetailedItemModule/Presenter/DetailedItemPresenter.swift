
import Foundation

protocol DetailedItemPresenterProtocol: AnyObject {
    func didLoadView()
    func didTapOnOpenResource()
}

final class DetailedItemPresenter: DetailedItemPresenterProtocol {

	private let interactor: DetailedItemInteractorProtocol?
	private let viewModel: NewsItemViewModel
	private let router: DetailedItemRouterProtocol
	private weak var view: DetaildItemViewProtocol?

	init(interactor: DetailedItemInteractorProtocol, view: DetaildItemViewProtocol, router: DetailedItemRouterProtocol, viewModel: NewsItemViewModel) {
		self.interactor = interactor
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

