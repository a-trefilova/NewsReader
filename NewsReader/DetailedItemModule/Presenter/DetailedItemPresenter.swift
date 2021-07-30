
import Foundation

protocol DetailedItemPresenterProtocol: AnyObject {
    func didLoadView()
    func didTapOnOpenResource()
}

final class DetailedItemPresenter: DetailedItemPresenterProtocol {

    var interactor: DetailedItemInteractorProtocol?
    private let newsItem: NewsItem
    private let router: DetailedItemRouterProtocol
    private weak var view: DetaildItemViewProtocol?

    init(view: DetaildItemViewProtocol, router: DetailedItemRouterProtocol, newsItem: NewsItem) {
        self.view = view
        self.router = router
        self.newsItem = newsItem
    }

    func didLoadView() {
        view?.setTitle(string: newsItem.title)
        view?.setDate(string: formateDateToString(date: newsItem.pubDate))
        view?.setDescription(string: newsItem.description)
        view?.setImage(string: newsItem.imageUrl)
        view?.setAuthorName(string: newsItem.author ?? "")
    }
    
    func didTapOnOpenResource() {
        let urlString = newsItem.link
        interactor?.validateUrl(urlString: urlString) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let validUrl):
                DispatchQueue.main.async { self.router.showSafariLink(validUrl: validUrl) }
            case .failure(let error):
                DispatchQueue.main.async { self.router.showErrorMessage(error.localizedDescription)}
            }
        }
    }
    
    private func formateDateToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        return dateFormatter.string(from: date)
    }
}
