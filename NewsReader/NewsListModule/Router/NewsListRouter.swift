
import UIKit

protocol NewsListRouterProtocol {
    func showDetailedViewController(for viewModelId: String)
    func showErrorMessage(_ message: String)
}

class NewsListRouter: NewsListRouterProtocol {

    private let rootView: NewsListViewController
    private let mainRouter: MainRouter
    init(rootView: NewsListViewController, mainRouter: MainRouter) {
        self.rootView = rootView
        self.mainRouter = mainRouter
    }

    func showDetailedViewController(for viewModelId: String) {
        mainRouter.showDetailedViewController(for: viewModelId)
    }

    func showErrorMessage(_ message: String) {
        let alert = UIAlertController(title: "Oops!", message: "Something went wrong! \(message)", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Confirm", style: .cancel)
        alert.addAction(confirmAction)
        rootView.present(alert, animated: true)
    }
    
}

