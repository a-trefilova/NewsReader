
import UIKit

protocol DetailedItemRouterProtocol {
    func showSafariLink(validUrl: URL)
    func showErrorMessage(_ message: String)
}

class DetailedItemRouter: DetailedItemRouterProtocol {

    private let rootView: DetailedItemVC
    private let mainRouter: MainRouter
    init(rootView: DetailedItemVC, mainRouter: MainRouter) {
        self.rootView = rootView
        self.mainRouter = mainRouter
    }

    func showSafariLink(validUrl: URL) {
        UIApplication.shared.open(validUrl, options: [:], completionHandler: { _ in })
    }
    
    func showErrorMessage(_ message: String) {
        let alert = UIAlertController(title: "Oops!", message: "Something went wrong! \(message)", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Confirm", style: .cancel)
        alert.addAction(confirmAction)
        rootView.present(alert, animated: true)
    }
}
