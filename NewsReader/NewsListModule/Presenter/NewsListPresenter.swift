
import Foundation

protocol NewsListPresenterProtocol: AnyObject {
    func showListOfItems()
    func showDetailItem(_ item: NewsItem)
}

final class NewsListPresenter: NewsListPresenterProtocol {

    var interactor: NewsListInteractorProtocol?
    var router: NewsReaderRouter?
    weak var view: NewsListViewProtocol?

    init(view: NewsListViewProtocol) {
        self.view = view
    }
   
    func showListOfItems() {
        interactor?.getListOfItems { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let items):
                DispatchQueue.main.async { self.view?.showListOfItems(items: items) }
            case .failure(let error):
                DispatchQueue.main.async { self.view?.showErrorMessage(error.localizedDescription) }
            }
        }
    }
    
    func showDetailItem(_ item: NewsItem) {
        router?.showDetailedViewController(for: item)
    }
    
}
