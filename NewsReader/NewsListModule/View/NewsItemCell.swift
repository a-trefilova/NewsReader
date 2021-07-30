
import UIKit

final class NewsItemCell: UITableViewCell {
    
    static let reuseId = "NewsItemCell"
    
    private let imageSize: CGFloat = 50
    private let padding: CGFloat = 10
    private let container: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let itemTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .label
        label.numberOfLines = 3
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
    private let itemImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        itemImage.image = nil
    }
    
    func render(_ viewModel: NewsItemCellViewModel) {
        itemTitle.text = viewModel.title
        itemDate.text = viewModel.date
        itemImage.image = viewModel.image.uploadedImage
    }
    
    private func layoutElements() {
        contentView.addSubview(container)
        container.addSubview(itemTitle)
        container.addSubview(itemDate)
        container.addSubview(itemImage)
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: contentView.topAnchor),
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            itemImage.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: padding),
            itemImage.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            itemImage.widthAnchor.constraint(equalToConstant: imageSize),
            itemImage.heightAnchor.constraint(equalToConstant: imageSize),

            itemTitle.leadingAnchor.constraint(equalTo: itemImage.trailingAnchor, constant: padding),
            itemTitle.topAnchor.constraint(equalTo: container.topAnchor, constant: padding),
            itemTitle.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -padding),
            itemTitle.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -padding),

            itemDate.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -padding),
            itemDate.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -padding),
            itemDate.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
}

