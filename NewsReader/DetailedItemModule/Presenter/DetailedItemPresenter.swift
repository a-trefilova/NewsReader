
import Foundation

protocol DetailedItemPresenterProtocol: AnyObject {
    func showDetailedInfo()
    func openResource()
}

final class DetailedItemPresenter: DetailedItemPresenterProtocol {
    
    weak var view: DetaildItemViewProtocol?
    var newsItem: NewsItem!
    var interactor: DetailedItemInteractorProtocol!
    
    init(view: DetaildItemViewProtocol) {
        self.view = view
    }
    func showDetailedInfo() {
        view?.setTitle(string: newsItem.title)
        view?.setDate(string: formateDateToString(date: newsItem.pubDate))
        view?.setDescription(string: newsItem.description)
        view?.setImage(string: newsItem.imageUrl)
        view?.setAuthorName(string: newsItem.author ?? "")
    }
    func openResource() {
        interactor.validateUrl(urlString: newsItem.link) { [weak self] validUrl in
            self?.view?.showSafariLink(validUrl: validUrl)
        }
    }
    
    private func formateDateToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        return dateFormatter.string(from: date)
    }
    
}
