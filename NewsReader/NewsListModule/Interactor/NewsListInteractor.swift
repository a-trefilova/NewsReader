
import Foundation

protocol NewsListInteractorProtocol {
    func getListOfItems(completion: @escaping (Result<[NewsItem], ErrorType>) -> Void)
}

final class NewsListInteractor: NewsListInteractorProtocol {

    private let service: NewsListServiceProtocol
    private weak var presenter: NewsListPresenterProtocol?

    init(presenter: NewsListPresenterProtocol, service: NewsListServiceProtocol) {
        self.presenter = presenter
        self.service = service
    }
    
    func getListOfItems(completion: @escaping (Result<[NewsItem], ErrorType>) -> Void) {
        service.fetchItems { result in
            completion(result)
        }
    }
}
