
import Foundation

protocol NewsListPresenterProtocol: AnyObject {
    func didLoadView()
    func didSelectItem(_ item: NewsItem)
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
                DispatchQueue.main.async { self.view?.showListOfItems(items: items) }
            case .failure(let error):
                DispatchQueue.main.async { self.router.showErrorMessage(error.localizedDescription) }
            }
        }
    }
    
    func didSelectItem(_ item: NewsItem) {
        router.showDetailedViewController(for: item)
    }
    
}
