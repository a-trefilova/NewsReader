
import UIKit

protocol NewsListRouterProtocol {
    func showDetailedViewController(for item: NewsItem)
    func showErrorMessage(_ message: String)
}

class NewsListRouter: NewsListRouterProtocol {

    private let rootView: NewsListVC
    private let mainRouter: MainRouter
    init(rootView: NewsListVC, mainRouter: MainRouter) {
        self.rootView = rootView
        self.mainRouter = mainRouter
    }

    func showDetailedViewController(for item: NewsItem) {
        mainRouter.showDetailedViewController(for: item)
    }

    func showErrorMessage(_ message: String) {
        let alert = UIAlertController(title: "Oops!", message: "Something went wrong! \(message)", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Confirm", style: .cancel)
        alert.addAction(confirmAction)
        rootView.present(alert, animated: true)
    }


}

