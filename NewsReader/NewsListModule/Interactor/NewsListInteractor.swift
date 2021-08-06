
import UIKit

protocol NewsListInteractorProtocol {
    func getListOfItems(completion: @escaping (Result<[NewsItemCellViewModel], ErrorType>) -> Void)
    func getImage(viewModelId: String, completion: @escaping (UIImage) -> Void)
}

final class NewsListInteractor: NewsListInteractorProtocol {

    private weak var presenter: NewsListPresenterProtocol?
    private let newsListService: NewsListServiceProtocol
    private let uploadImageService: UploadImageServiceProtocol
    private let dataStore: DataStore
	private let viewModelFactory: ViewModelFactoryProtocol

	init(presenter: NewsListPresenterProtocol, newsListService: NewsListServiceProtocol, uploadImageService: UploadImageServiceProtocol, dataStore: DataStore, viewModelFactory: ViewModelFactoryProtocol) {
        self.presenter = presenter
        self.newsListService = newsListService
        self.uploadImageService = uploadImageService
        self.dataStore = dataStore
		self.viewModelFactory = viewModelFactory
    }
    
    func getListOfItems(completion: @escaping (Result<[NewsItemCellViewModel], ErrorType>) -> Void) {
        newsListService.fetchItems { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.dataStore.saveData(data: data)
                let viewModels = data.map { self.processDTO(dto: $0) }
                completion(.success(viewModels))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

     func getImage(viewModelId: String, completion: @escaping (UIImage) -> Void) {
        guard let urlString = dataStore.dataTransferObjects.first(where: { $0.id == viewModelId})?.imageUrl else { return }
		uploadImageService.fetchItems(forEntryPoint: urlString, completion: completion)
    }

    private func processDTO(dto: NewsItemDTO) -> NewsItemCellViewModel {
		viewModelFactory.getCellViewModel(for: dto)
    }
}
