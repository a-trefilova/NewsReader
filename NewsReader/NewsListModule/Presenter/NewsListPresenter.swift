
import Foundation

protocol NewsListPresenterProtocol: AnyObject {
    func showListOfItems()
    func showDetailItem(item: NewsItem)
}

final class NewsListPresenter: NewsListPresenterProtocol {

    weak var view: NewsListViewProtocol?
    var interactor: NewsListInteractorProtocol!
    var router: NewsReaderRouter!  // FIXME: заменить на протокол
    
    init(view: NewsListViewProtocol) {
        self.view = view
    }
   
    func showListOfItems() {
        interactor.getListOfItems { [weak self] newsItems in
            guard let self = self else { fatalError()}
            DispatchQueue.main.async {
                self.view?.showListOfItems(items: newsItems)
            }
        }
    }
    
    func showDetailItem(item: NewsItem) {
        router.showDetailedViewController(newsItem: item)
    }
    
}
