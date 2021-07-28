
import UIKit

final class NewsItemCell: UITableViewCell {
    
    static let reuseId = "NewsItemCell"
    
    private let imageSize: CGFloat = 50
    private let padding: CGFloat = 10
    private var container: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private var itemTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .label
        label.numberOfLines = 3
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
    private var itemImage = NewsImageView(frame: .zero)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        itemImage.image = nil
    }
    
    func configure(with newsItem: NewsItem) {
        itemTitle.text = newsItem.title
        itemDate.text = formateDateToString(date: newsItem.pubDate)
        itemImage.downloadImage(from: newsItem.imageUrl)
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
    
    private func formateDateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd,yyyy"
        return formatter.string(from: date)
    }
}

