
import Foundation

protocol NewsListInteractorProtocol {
    func getListOfItems(completion: @escaping (Result<[NewsItem], ErrorType>) -> Void)
}

final class NewsListInteractor: NewsListInteractorProtocol {

    private let service: NewsListServiceProtocol = NewsListService()
    weak var presenter: NewsListPresenterProtocol?

    init(presenter: NewsListPresenterProtocol) {
        self.presenter = presenter
    }
    
    func getListOfItems(completion: @escaping (Result<[NewsItem], ErrorType>) -> Void) {
        service.fetchItems { result in
            completion(result)
        }
    }
}
