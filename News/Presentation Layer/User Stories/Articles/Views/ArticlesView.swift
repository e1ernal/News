//
//  NewsView.swift
//  News
//
//  Created by e1ernal on 12.07.2024.
//

import UIKit

final class ArticlesView: UIView {
    // MARK: - Public Properties
    
    // MARK: - Private Properties
    private let articlesTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        return tableView
    }()
    
    private let categoriesView = CategoriesCollectionView()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Configure View
        addSubview(articlesTableView)
        addSubview(categoriesView)
        backgroundColor = .systemBackground
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Configure constraints
        NSLayoutConstraint.activate([
            categoriesView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            categoriesView.leadingAnchor.constraint(equalTo: leadingAnchor),
            categoriesView.trailingAnchor.constraint(equalTo: trailingAnchor),
            categoriesView.heightAnchor.constraint(equalToConstant: categoriesView.height + 15),
            
            articlesTableView.topAnchor.constraint(equalTo: categoriesView.bottomAnchor),
            articlesTableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            articlesTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            articlesTableView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    // MARK: - Public Methods
    func configure(
        delegate: UITableViewDelegate,
        dataSource: UITableViewDataSource,
        registerCell: [TableViewCell.Type]
    ) {
        articlesTableView.delegate = delegate
        articlesTableView.dataSource = dataSource
        registerCell.forEach { articlesTableView.register($0, forCellReuseIdentifier: $0.reuseIdentifier) }
    }
    
    func reload() {
        articlesTableView.reloadData()
        if articlesTableView.visibleCells.isEmpty {
            // Set view to empty tableView
            let backgroundLabel = UILabel()
            backgroundLabel.textAlignment = .center
            backgroundLabel.numberOfLines = 0
            
            let imageAttachment = NSTextAttachment()
            let image = UIImage(
                systemName: "newspaper",
                withConfiguration: UIImage.SymbolConfiguration(pointSize: 40, weight: .regular)
            )?.withTintColor(.label)
            
            imageAttachment.image = image
            let imageString = NSAttributedString(attachment: imageAttachment)
            
            let backgroundText = NSMutableAttributedString()
            backgroundText.append(imageString)
            
            let titleText = "\nNo News"
            let subtitleText = "\nTry to change the search parameters\nor come back later"
            backgroundText.append(NSAttributedString(string: titleText + subtitleText))
            
            let titleFontAttribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: .bold)]
            let subtitleFontAttribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13, weight: .regular)]
            let mainColorAttribute = [NSAttributedString.Key.foregroundColor: UIColor.label]
            let secondaryColorAttribute = [NSAttributedString.Key.foregroundColor: UIColor.secondaryLabel]
            
            backgroundText.addAttributes(
                titleFontAttribute,
                range: NSRange(location: 1, length: titleText.count)
            )
            
            backgroundText.addAttributes(
                subtitleFontAttribute,
                range: NSRange(location: titleText.count + 1, length: subtitleText.count)
            )
            
            backgroundText.addAttributes(
                mainColorAttribute,
                range: NSRange(location: 1, length: titleText.count)
            )
            
            backgroundText.addAttributes(
                secondaryColorAttribute,
                range: NSRange(location: titleText.count + 1, length: subtitleText.count)
            )
            
            backgroundLabel.attributedText = backgroundText
            
            articlesTableView.backgroundView = backgroundLabel
        } else {
            articlesTableView.backgroundView = nil
        }
        articlesTableView.tableFooterView = nil
    }
    
    func reload(row: Int, in section: Int) {
        let numberOfSections = articlesTableView.numberOfSections
        guard 0...numberOfSections ~= section else { return }
        let numberOfRows = articlesTableView.numberOfRows(inSection: section)
        guard 0...numberOfRows ~= row else { return }
        let indexPath = IndexPath(row: row, section: section)
        
        UIView.transition(
            with: articlesTableView,
            duration: 0.3,
            options: .curveEaseInOut,
            animations: {
                self.articlesTableView.reloadRows(at: [indexPath], with: .none)
            }, completion: nil
        )
    }
    
    // MARK: - Private Methods
    
    // MARK: - Deinitialization
    deinit { print("Deinit \(String(describing: ArticlesView.self))") }
}
