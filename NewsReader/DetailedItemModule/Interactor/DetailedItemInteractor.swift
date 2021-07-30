
import UIKit

protocol DetailedItemInteractorProtocol: AnyObject {
    func getViewModel(completion: @escaping (DetailedItemViewModel) -> Void)
    func validateUrl(completion: @escaping (Result<URL, ErrorType>) -> Void)
}

final class DetailedItemInteractor: DetailedItemInteractorProtocol {

    private let dataStore: DataStore
    private weak var presenter: DetailedItemPresenterProtocol?
    private let id: String

    init(presenter: DetailedItemPresenterProtocol, dataStore: DataStore, id: String) {
        self.presenter = presenter
        self.dataStore = dataStore
        self.id = id
    }

    func getViewModel(completion: @escaping (DetailedItemViewModel) -> Void) {
        guard let dto = dataStore.dataTransferObjects.first(where: { $0.id == id}) else { return }
        let viewModel = transformDtoToViewModel(dto: dto)
        completion(viewModel)
    }

    func validateUrl(completion: @escaping (Result<URL, ErrorType>) -> Void) {
        guard let dto = dataStore.dataTransferObjects.first(where: { $0.id == id}) else { return }
        let urlString = dto.link 
        if let url = URL(string: urlString) {
            completion(.success(url))
        } else {
            completion(.failure(.invalidEntryPoint))
        }
    }

    private func transformDtoToViewModel(dto: NewsItemDTO) -> DetailedItemViewModel {
        let uploadImageService: UploadImageService = UploadImageService(entryPoint: dto.imageUrl!, cache: dataStore.cache)
        var uploadedImage: UIImage = UIImage()
        let group = DispatchGroup()
        group.enter()
        DispatchQueue.global().async {
            uploadImageService.fetchItems { (image) in
                uploadedImage = image ?? UIImage()
                group.leave()
            }
        }
        group.wait()
        let viewModel = DetailedItemViewModel(id: dto.id,
                                              image: Image(urlString: dto.imageUrl ?? "", uploadedImage: uploadedImage),
                                              title: dto.title,
                                              description: dto.description,
                                              authorName: dto.author ?? "",
                                              date: formateDateToString(date: dto.pubDate))
        return viewModel
    }

    private func formateDateToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        return dateFormatter.string(from: date)
    }
    
}
