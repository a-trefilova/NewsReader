
import Foundation

protocol DetailedItemPresenterProtocol: AnyObject {
    func showDetailedInfo()
    func openResource()
}

final class DetailedItemPresenter: DetailedItemPresenterProtocol {

    var newsItem: NewsItem?
    var interactor: DetailedItemInteractorProtocol?
    weak var view: DetaildItemViewProtocol?

    init(view: DetaildItemViewProtocol) {
        self.view = view
    }

    func showDetailedInfo() {
        guard let newsItem = newsItem else { return }
        view?.setTitle(string: newsItem.title)
        view?.setDate(string: formateDateToString(date: newsItem.pubDate))
        view?.setDescription(string: newsItem.description)
        view?.setImage(string: newsItem.imageUrl)
        view?.setAuthorName(string: newsItem.author ?? "")
    }
    
    func openResource() {
        guard let urlString = newsItem?.link else { return }
        interactor?.validateUrl(urlString: urlString) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let validUrl):
                DispatchQueue.main.async { self.view?.showSafariLink(validUrl: validUrl) }
            case .failure(let error):
                DispatchQueue.main.async { self.view?.showErrorMessage(error.localizedDescription) }
            }
        }
    }
    
    private func formateDateToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        return dateFormatter.string(from: date)
    }
}
