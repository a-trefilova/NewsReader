
import UIKit

protocol DetailedItemInteractorProtocol: AnyObject {
    func validateUrl(urlString: String, completion: @escaping (Result<URL, ErrorType>) -> Void)
}

final class DetailedItemInteractor: DetailedItemInteractorProtocol {

    private weak var presenter: DetailedItemPresenterProtocol?
    
    init(presenter: DetailedItemPresenterProtocol) {
        self.presenter = presenter
    }
    
    func validateUrl(urlString: String, completion: @escaping (Result<URL, ErrorType>) -> Void) {
        if let url = URL(string: urlString) {
            completion(.success(url))
        } else {
            completion(.failure(.invalidEntryPoint))
        }
    }
}
