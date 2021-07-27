
import UIKit

protocol NewsListViewProtocol: AnyObject {
    func prepareView()
    func showListOfItems(items: [NewsItem])
}

class NewsListVC: UIViewController {
    
    private var tableView = UITableView(frame: .zero, style: .grouped)
    private var newsItemsList: [NewsItem] = []
    var presenter: NewsListPresenterProtocol!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.configureView()
        presenter.showListOfItems()
        setupTableView()
        layoutTableView()
    }

    private func setupTableView() {
        view.backgroundColor = .systemBackground
        tableView.register(NewsItemCell.self, forCellReuseIdentifier: NewsItemCell.reuseId)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func layoutTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension NewsListVC: NewsListViewProtocol {
    
    func prepareView() {

    }
    
    func showListOfItems(items: [NewsItem]) {
        newsItemsList = items
        tableView.reloadData()
    }
    
}

extension NewsListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        newsItemsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsItemCell.reuseId, for: indexPath) as? NewsItemCell else { return UITableViewCell() }
        let currentItem = newsItemsList[indexPath.row]
        cell.configure(with: currentItem)
        return cell
    }
    
    
}

extension NewsListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
}
