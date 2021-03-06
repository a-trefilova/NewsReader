
import UIKit

protocol DetaildItemViewProtocol: AnyObject {
    func render(viewModel: NewsItemViewModel)
	func presentViewController(_ viewController: UIViewController, animated: Bool)
}

final class DetailedItemViewController: UIViewController {
    
    var presenter: DetailedItemPresenterProtocol?

    private let padding: CGFloat = 20
    private let imageHeight: CGFloat = 120
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private let itemFullTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .label
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let itemDescription: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .label
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let itemDate: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .secondaryLabel
        label.numberOfLines = 1
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let authorName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let openResourceButton: UIButton = {
        let button = UIButton()
        button.setTitle("View original resource", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(openResourceButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var subviewHierarchy: [UIView: [UIView]] = {
        guard let view = view else { return [:]}
        let dict = [view: [imageView, itemFullTitle, itemDescription, itemDate, authorName, openResourceButton]]
        return dict
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutSubviews()
        presenter?.didLoadView()
    }
    
    @objc
    func openResourceButtonTapped() {
        presenter?.didTapOnOpenResource()
    }
    
    private func layoutSubviews() {
        view.backgroundColor = .systemBackground
        subviewHierarchy.keys.forEach { parentView in
            guard let subviews = subviewHierarchy[parentView] else { return }
            subviews.forEach({ parentView.addSubview($0)})
        }
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            imageView.heightAnchor.constraint(equalToConstant: imageHeight),
            
            itemFullTitle.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: padding),
            itemFullTitle.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            itemFullTitle.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            
            itemDescription.topAnchor.constraint(equalTo: itemFullTitle.bottomAnchor, constant: padding),
            itemDescription.leadingAnchor.constraint(equalTo: itemFullTitle.leadingAnchor),
            itemDescription.trailingAnchor.constraint(equalTo: itemFullTitle.trailingAnchor),
            
            authorName.topAnchor.constraint(equalTo: itemDescription.bottomAnchor, constant: padding),
            authorName.leadingAnchor.constraint(equalTo: itemDescription.leadingAnchor),
            authorName.trailingAnchor.constraint(equalTo: itemDate.leadingAnchor, constant: -padding),
            
            itemDate.topAnchor.constraint(equalTo: authorName.topAnchor),
            itemDate.trailingAnchor.constraint(equalTo: itemDescription.trailingAnchor),
            
            openResourceButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding),
            openResourceButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            openResourceButton.heightAnchor.constraint(equalToConstant: 54),
            openResourceButton.widthAnchor.constraint(equalToConstant: 180)
        ])
    }

}

//MARK: - DetaildItemViewProtocol
extension DetailedItemViewController: DetaildItemViewProtocol {

	func presentViewController(_ viewController: UIViewController, animated: Bool) {
		present(viewController, animated: animated)
	}

    func render(viewModel: NewsItemViewModel) {
        itemFullTitle.text = viewModel.title
        itemDescription.text = viewModel.description
        imageView.image = viewModel.image.uploadedImage
        itemDate.text = viewModel.date
        authorName.text = viewModel.authorName
    }

}

