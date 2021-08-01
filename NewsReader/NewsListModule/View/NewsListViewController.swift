
import UIKit

protocol NewsListViewProtocol: AnyObject {
    func showListOfViewModels(viewModels: [NewsItemCellViewModel])
    func updateCell(at indexPath: IndexPath, with image: UIImage)
}

final class NewsListViewController: UIViewController {

    var presenter: NewsListPresenterProtocol?

    private let tableView = UITableView(frame: .zero, style: .grouped)
    private var viewModelList: [NewsItemCellViewModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        layoutTableView()
        presenter?.didLoadView()
    }

    private func setupTableView() {
        view.backgroundColor = .systemBackground
        let reuseId = CellIdentifierFactory().getId(forCellType: NewsItemCell.self)
        tableView.register(NewsItemCell.self, forCellReuseIdentifier: reuseId)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100 
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
    func updateCell(at indexPath: IndexPath, with image: UIImage) {
        guard let cell = tableView.cellForRow(at: indexPath) as? NewsItemCell else { return }
        cell.updateItemImage(image)
    }

    func showListOfViewModels(viewModels: [NewsItemCellViewModel]) {
        viewModelList = viewModels
        tableView.reloadData()
    }

}

//MARK: - UITableViewDataSource
extension NewsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModelList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let defaultCell = UITableViewCell()
        let reuseId = CellIdentifierFactory().getId(forCellType: NewsItemCell.self)
        let currentIndex = indexPath.row
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath) as? NewsItemCell,
              currentIndex <= viewModelList.count - 1  else {
            return defaultCell
        }
        let viewModel = viewModelList[currentIndex]
        cell.render(viewModel)
        presenter?.didLoadCell(at: indexPath, viewModelId: viewModel.id)
        return cell
    }
    
}

//MARK: - UITableViewDelegate
extension NewsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let currentIndex = indexPath.row
        guard currentIndex <= viewModelList.count - 1 else { return }
        let currentItem = viewModelList[indexPath.row]
        presenter?.didSelectViewModel(currentItem.id)
    }
}
