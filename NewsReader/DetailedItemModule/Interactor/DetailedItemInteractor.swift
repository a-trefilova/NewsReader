
import UIKit

protocol DetailedItemInteractorProtocol: AnyObject {
    func validateUrl(completion: @escaping (Result<URL, ErrorType>) -> Void)
}

final class DetailedItemInteractor: DetailedItemInteractorProtocol {

    private let dataStore: DataStoreProtocol
    private let uploadImageService: UploadImageServiceProtocol
	private let urlValidationService: URLValidationServiceProtocol?

	init(dataStore: DataStoreProtocol, uploadImageService: UploadImageServiceProtocol, urlValidationService: URLValidationServiceProtocol?) {
        self.dataStore = dataStore
        self.uploadImageService = uploadImageService
		self.urlValidationService = urlValidationService
    }

    func validateUrl(completion: @escaping (Result<URL, ErrorType>) -> Void) {
		urlValidationService?.getValidUrl(completion: completion)
    }

}
