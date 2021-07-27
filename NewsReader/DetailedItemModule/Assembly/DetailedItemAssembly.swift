
import UIKit

final class DetailedItemAssembly {
    func assembleDetailedItemModule(newsItem: NewsItem) -> UIViewController {
        let view = DetailedItemVC()
        let presenter = DetailedItemPresenter(view: view)
        let interactor = DetailedItemInteractor(presenter: presenter)
       
        view.presenter = presenter
        presenter.interactor = interactor
        presenter.newsItem = newsItem
        
        return view
    }
}
