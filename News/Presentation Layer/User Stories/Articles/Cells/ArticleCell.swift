//
//  NewsCell.swift
//  News
//
//  Created by e1ernal on 12.07.2024.
//

import UIKit

var imageCache = NSCache<NSString, UIImage>()

final class ArticleCell: TableViewCell {
    // MARK: - Public Properties
    
    // MARK: - Private Properties
    private var imageUrl: String? {
        didSet {
            guard let imageUrl else {
                topImageView.image = nil
                return
            }
            
            guard let image = imageCache.object(forKey: imageUrl as NSString) else {
                Task {
                    let image = await ArticlesNetworkService.getImage(urlString: imageUrl)
                    topImageView.image = image
                    guard let image else { return }
                    imageCache.setObject(image, forKey: imageUrl as NSString)
                }
                
                return
            }
            
            topImageView.image = image
        }
    }
    
    private var article: Article? {
        didSet {
            sourceLabel.text = article?.source.name
            titleLabel.text = article?.title
            descriptionLabel.text = article?.description
            authorLabel.text = article?.author
            imageUrl = article?.urlToImage
            dateLabel.text = article?.publishedAt
        }
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    private let sourceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 10, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        return label
    }()
    
    private let topImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 5
        
        // Lower priority to avoid warnings
        let heightConstraint = imageView.heightAnchor.constraint(equalToConstant: 200)
        heightConstraint.priority = .defaultHigh
        heightConstraint.isActive = true
        
        return imageView
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 10
        return stack
    }()
    
    private let backView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 15
        return view
    }()
    
    private let subActionsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let configuration = UIImage.SymbolConfiguration(scale: .small)
        let image = UIImage(systemName: "ellipsis", withConfiguration: configuration)?
            .withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.tintColor = .secondaryLabel
        
        button.showsMenuAsPrimaryAction = true
        return button
    }()
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        configureConstraints()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        article = nil
    }
    
    // MARK: - Actions
    private func sourceLink() {
        guard let urlString = article?.url, let urlLink = URL(string: urlString)
        else { return }
        
        if UIApplication.shared.canOpenURL(urlLink) {
            UIApplication.shared.open(urlLink, options: [:], completionHandler: nil)
        }
    }
    
    // MARK: - Public Methods
    func configure(article: Article?) {
        self.article = article
        
        configureStack()
        
        let readSource = UIAction(
            title: "Read the source",
            image: UIImage(systemName: "link")
        ) { _ in self.sourceLink() }
        
        subActionsButton.menu = UIMenu(title: "", children: [readSource])
    }
    
    // MARK: - Private Methods
    override func configureView() {
        contentView.isUserInteractionEnabled = true
        
        addSubview(backView)
        addSubview(stackView)
        addSubview(subActionsButton)
    }
    
    func configureStack() {
        stackView.subviews.forEach { $0.removeFromSuperview() }
        
        if article?.urlToImage != nil { stackView.addArrangedSubview(topImageView) }
        
        stackView.addArrangedSubview(sourceLabel)
        stackView.setCustomSpacing(0, after: sourceLabel)
        stackView.addArrangedSubview(dateLabel)
        stackView.addArrangedSubview(titleLabel)
        
        if article?.description != nil { stackView.addArrangedSubview(descriptionLabel) }
        if article?.author != nil { stackView.addArrangedSubview(authorLabel) }
        
        NSLayoutConstraint.activate([
            subActionsButton.topAnchor.constraint(equalTo: sourceLabel.topAnchor),
            subActionsButton.bottomAnchor.constraint(equalTo: dateLabel.bottomAnchor),
            subActionsButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor)
        ])
    }
    
    override func configureConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 2 * 10),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -2 * 10),
            
            backView.topAnchor.constraint(equalTo: stackView.topAnchor, constant: -10),
            backView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10),
            backView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: -10),
            backView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 10)
        ])
    }
}
