
import UIKit

protocol DetailedItemRouterProtocol {
    func showSafariLink(validUrl: URL)
    func showErrorMessage(_ message: String)
}

final class DetailedItemRouter: DetailedItemRouterProtocol {

    private let rootView: DetaildItemViewProtocol
    private let mainRouter: MainRouterProtocol
    init(rootView: DetaildItemViewProtocol, mainRouter: MainRouterProtocol) {
        self.rootView = rootView
        self.mainRouter = mainRouter
    }

    func showSafariLink(validUrl: URL) {
        mainRouter.openResource(resource: validUrl)
    }
    
    func showErrorMessage(_ message: String) {
        let alert = UIAlertController(title: "Obops!", message: "Something went wrong! \(message)", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Confirm", style: .cancel)
        alert.addAction(confirmAction)
		rootView.presentViewController(alert, animated: true)
    }
}
