
import Foundation

protocol DetailedItemPresenterProtocol: AnyObject {
    func didLoadView()
    func didTapOnOpenResource()
}

final class DetailedItemPresenter: DetailedItemPresenterProtocol {

    var interactor: DetailedItemInteractorProtocol?
    private let viewModelId: String
    private let router: DetailedItemRouterProtocol
    private weak var view: DetaildItemViewProtocol?

    init(view: DetaildItemViewProtocol, router: DetailedItemRouterProtocol, viewModelId: String) {
        self.view = view
        self.router = router
        self.viewModelId = viewModelId
    }

	func didLoadView() {
		self.interactor?.getViewModel(completion: { (viewModel) in
			DispatchQueue.main.async { self.view?.render(viewModel: viewModel) }
		})
	}
    
    func didTapOnOpenResource() {
        interactor?.validateUrl { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let validUrl):
                DispatchQueue.main.async { self.router.showSafariLink(validUrl: validUrl) }
            case .failure(let error):
				DispatchQueue.main.async { self.router.showErrorMessage(error.description) }
            }
        }
    }
    
    private func formateDateToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        return dateFormatter.string(from: date)
    }
}
