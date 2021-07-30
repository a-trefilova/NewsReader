
import UIKit

protocol NewsListViewProtocol: AnyObject {
    func showListOfItems(items: [NewsItem])
}

final class NewsListViewController: UIViewController {

    var presenter: NewsListPresenterProtocol?

    private let tableView = UITableView(frame: .zero, style: .grouped)
    private var newsItemsList: [NewsItem] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        layoutTableView()
        presenter?.didLoadView()
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

//MARK: - NewsListViewProtocol
extension NewsListViewController: NewsListViewProtocol {
    func showListOfItems(items: [NewsItem]) {
        newsItemsList = items
        tableView.reloadData()
    }
    
}

//MARK: - UITableViewDataSource
extension NewsListViewController: UITableViewDataSource {
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

//MARK: - UITableViewDelegate
extension NewsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let currentItem = newsItemsList[indexPath.row]
        presenter?.didSelectItem(currentItem)
    }
}
