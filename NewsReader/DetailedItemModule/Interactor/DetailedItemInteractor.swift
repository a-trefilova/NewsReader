
import UIKit

protocol DetailedItemInteractorProtocol: AnyObject {
    func validateUrl(urlString: String, completion: @escaping (URL) -> Void)
}

final class DetailedItemInteractor: DetailedItemInteractorProtocol {

    weak var presenter: DetailedItemPresenterProtocol?
    
    init(presenter: DetailedItemPresenterProtocol) {
        self.presenter = presenter
    }
    
    func validateUrl(urlString: String, completion: @escaping (URL) -> Void) {
        if let url = URL(string: urlString) {
            completion(url)
        }
    }
    
}
