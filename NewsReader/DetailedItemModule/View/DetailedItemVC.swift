
import UIKit

protocol DetaildItemViewProtocol: AnyObject {
    func setTitle(string: String)
    func setDescription(string: String)
    func setImage(string: String?)
    func setDate(string: String)
    func setAuthorName(string: String)
    func showSafariLink(validUrl: URL)
}

final class DetailedItemVC: UIViewController {
    
    var presenter: DetailedItemPresenterProtocol!

    private let padding: CGFloat = 20
    private let imageHeight: CGFloat = 120
    private var imageView = NewsImageView(frame: .zero)
    private var itemFullTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .label
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private var itemDescription: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .label
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private var itemDate: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .secondaryLabel
        label.numberOfLines = 1
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var authorName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var openResourceButton: UIButton = {
        let button = UIButton()
        button.setTitle("View original resource", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(openResourceButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutSubviews()
        presenter.showDetailedInfo()
    }
    

    @objc
    func openResourceButtonTapped() {
        presenter.openResource()
    }
    
    private func layoutSubviews() {
        view.backgroundColor = .systemBackground
        view.addSubview(imageView)
        view.addSubview(itemFullTitle)
        view.addSubview(itemDescription)
        view.addSubview(itemDate)
        view.addSubview(authorName)
        view.addSubview(openResourceButton)
        
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
extension DetailedItemVC: DetaildItemViewProtocol {
    func setTitle(string: String) {
        itemFullTitle.text = string
    }
    
    func setDescription(string: String) {
        itemDescription.text = string
    }
    
    func setImage(string: String?) {
        imageView.downloadImage(from: string)
    }
    
    func setDate(string: String) {
        itemDate.text = string
    }
    
    func setAuthorName(string: String) {
        authorName.text = string
    }
    
    func showSafariLink(validUrl: URL) {
        UIApplication.shared.open(validUrl, options: [:], completionHandler: { _ in })
    }
    
}

