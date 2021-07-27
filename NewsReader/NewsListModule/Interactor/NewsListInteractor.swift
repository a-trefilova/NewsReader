
import Foundation

protocol NewsListInteractorProtocol {
    func getListOfItems(completion: @escaping ([NewsItem]) -> Void)
}

final class NewsListInteractor: NewsListInteractorProtocol {
    weak var presenter: NewsListPresenterProtocol!
    let service: NewsListServiceProtocol = NewsListService()
    
    init(presenter: NewsListPresenterProtocol) {
        self.presenter = presenter
    }
    
    func getListOfItems(completion: @escaping ([NewsItem]) -> Void) {
        service.fetchItems { items in
            completion(items)
        }
    }
}
