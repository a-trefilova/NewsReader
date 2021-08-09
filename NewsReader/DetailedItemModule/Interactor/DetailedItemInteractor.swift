
import UIKit

protocol DetailedItemInteractorProtocol: AnyObject {
    func getViewModel(completion: @escaping (DetailedItemViewModel) -> Void)
    func validateUrl(completion: @escaping (Result<URL, ErrorType>) -> Void)
}

final class DetailedItemInteractor: DetailedItemInteractorProtocol {

    private weak var presenter: DetailedItemPresenterProtocol?
    private let dataStore: DataStoreProtocol
    private let uploadImageService: UploadImageServiceProtocol
	private let urlValidationService: URLValidationServiceProtocol?
	private let viewModelFactory: ViewModelFactoryProtocol
    private let dataObjectId: String

	init(presenter: DetailedItemPresenterProtocol, dataStore: DataStoreProtocol, uploadImageService: UploadImageServiceProtocol, urlValidationService: URLValidationServiceProtocol?, viewModelFactory: ViewModelFactoryProtocol, dataObjectId: String) {
        self.presenter = presenter
        self.dataStore = dataStore
        self.uploadImageService = uploadImageService
		self.urlValidationService = urlValidationService
		self.viewModelFactory = viewModelFactory
        self.dataObjectId = dataObjectId
    }

    func getViewModel(completion: @escaping (DetailedItemViewModel) -> Void) {
        guard let dto = dataStore.dataTransferObjects.first(where: { $0.id == dataObjectId}) else { return }
        let viewModel = transformDtoToViewModel(dto: dto)
        completion(viewModel)
    }

    func validateUrl(completion: @escaping (Result<URL, ErrorType>) -> Void) {
		urlValidationService?.getValidUrl(completion: completion)
    }

    private func transformDtoToViewModel(dto: NewsItemDTO) -> DetailedItemViewModel {
		viewModelFactory.getDetailViewModel(for: dto, uploadImageService: uploadImageService)
    }
}
