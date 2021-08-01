
import UIKit

protocol DetailedItemRouterProtocol {
    func showSafariLink(validUrl: URL)
    func showErrorMessage(_ message: String)
}

class DetailedItemRouter: DetailedItemRouterProtocol {

    private let rootView: DetailedItemViewController
    private let mainRouter: MainRouter
    init(rootView: DetailedItemViewController, mainRouter: MainRouter) {
        self.rootView = rootView
        self.mainRouter = mainRouter
    }

    func showSafariLink(validUrl: URL) {
        mainRouter.openResource(resource: validUrl)
    }
    
    func showErrorMessage(_ message: String) {
        let alert = UIAlertController(title: "Oops!", message: "Something went wrong! \(message)", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Confirm", style: .cancel)
        alert.addAction(confirmAction)
        rootView.present(alert, animated: true)
    }
}
