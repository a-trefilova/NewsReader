
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

    init(presenter: NewsListPresenterProtocol, newsListService: NewsListServiceProtocol, uploadImageService: UploadImageServiceProtocol, dataStore: DataStore) {
        self.presenter = presenter
        self.newsListService = newsListService
        self.uploadImageService = uploadImageService
        self.dataStore = dataStore
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
        uploadImageService.fetchItems(forEntryPoint: urlString) { (image) in
            completion(image ?? UIImage())
        }
    }

    private func processDTO(dto: NewsItemDTO) -> NewsItemCellViewModel {
        let title = dto.title
        let description = dto.description.cut(maxLength: 100)
        let date = self.turnDateIntoString(date: dto.pubDate)
        let image = Image(urlString: dto.imageUrl ?? "", uploadedImage: UIImage())
        let id = dto.id
        let cellViewModel = NewsItemCellViewModel(id: id, title: title, description: description, date: date, image: image)
        return cellViewModel
    }

    private func turnDateIntoString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd,yyyy"
        return formatter.string(from: date)
    }
}
