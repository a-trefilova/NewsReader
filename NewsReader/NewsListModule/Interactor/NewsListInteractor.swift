
import UIKit

protocol NewsListInteractorProtocol {
    func getListOfItems(completion: @escaping (Result<[NewsItemCellViewModel], ErrorType>) -> Void)
}

final class NewsListInteractor: NewsListInteractorProtocol {

    private let service: NewsListServiceProtocol
    private weak var presenter: NewsListPresenterProtocol?
    private let dataStore: DataStore

    init(presenter: NewsListPresenterProtocol, service: NewsListServiceProtocol, dataStore: DataStore) {
        self.presenter = presenter
        self.service = service
        self.dataStore = dataStore
    }
    
    func getListOfItems(completion: @escaping (Result<[NewsItemCellViewModel], ErrorType>) -> Void) {
        service.fetchItems { [weak self] result in
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

    private func processDTO(dto: NewsItemDTO) -> NewsItemCellViewModel {
        let title = dto.title
        let date = self.turnDateIntoString(date: dto.pubDate)
        let image = Image(urlString: dto.imageUrl ?? "", uploadedImage: UIImage())
        let id = dto.id
        let cellViewModel = NewsItemCellViewModel(id: id, title: title, date: date, image: image)
        return cellViewModel
    }


    private func turnDateIntoString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd,yyyy"
        return formatter.string(from: date)
    }
}
