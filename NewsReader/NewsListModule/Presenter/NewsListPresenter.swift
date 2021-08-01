
import Foundation

protocol NewsListPresenterProtocol: AnyObject {
    func didLoadView()
    func didSelectViewModel(_ viewModelId: String)
    func didLoadCell(at indexPath: IndexPath, viewModelId: String)
}

final class NewsListPresenter: NewsListPresenterProtocol {

    var interactor: NewsListInteractorProtocol?
    private var router: NewsListRouterProtocol
    private weak var view: NewsListViewProtocol?

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
                DispatchQueue.main.async { self.router.showErrorMessage(error.localizedDescription) }
            }
        }
    }

    func didSelectViewModel(_ viewModelId: String) {
        router.showDetailedViewController(for: viewModelId)
    }

    func didLoadCell(at indexPath: IndexPath, viewModelId: String) {
        DispatchQueue.global(qos: .userInteractive).async {
            self.interactor?.getImage(viewModelId: viewModelId) { image in
                DispatchQueue.main.async { self.view?.updateCell(at: indexPath, with: image)}
            }
        }
    }
}
