
import UIKit

protocol NewsListViewProtocol: AnyObject {
    func prepareView()
    func showListOfItems(items: [NewsItem])
}

class NewsListVC: UIViewController {
    
    var presenter: NewsListPresenterProtocol!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.configureView()
        presenter.showListOfItems()
    }

}

extension NewsListVC: NewsListViewProtocol {
    
    func prepareView() {
        view.backgroundColor = .red
    }
    
    func showListOfItems(items: [NewsItem]) {
        print("Showing empty items")
    }
    
}
