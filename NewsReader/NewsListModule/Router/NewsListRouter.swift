
import UIKit

protocol NewsListRouterProtocol {
    func showDetailedViewController(_ newsItemViewModel: NewsItemViewModel)
    func showErrorMessage(_ message: String)
}

final class NewsListRouter: NewsListRouterProtocol {

    private let rootView: NewsListViewProtocol
    private let mainRouter: MainRouterProtocol
    init(rootView: NewsListViewProtocol, mainRouter: MainRouterProtocol) {
        self.rootView = rootView
        self.mainRouter = mainRouter
    }

    func showDetailedViewController(_ newsItemViewModel: NewsItemViewModel) {
        mainRouter.showDetailedViewController(newsItemViewModel)
    }

    func showErrorMessage(_ message: String) {
        let alert = UIAlertController(title: "Oops!", message: "Something went wrong! \(message)", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Confirm", style: .cancel)
        alert.addAction(confirmAction)
		rootView.presentViewController(alert, animated: true)
    }
    
}

