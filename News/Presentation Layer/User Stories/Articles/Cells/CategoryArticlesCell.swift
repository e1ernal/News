//
//  CategoryCell.swift
//  News
//
//  Created by e1ernal on 16.07.2024.
//

import UIKit

final class CategoryArticlesCell: CollectionViewCell {
    // MARK: - Public Properties
    public var category: String = ""
    
    // MARK: - Private Properties
    private let articlesTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.register(ArticleCell.self, forCellReuseIdentifier: ArticleCell.reuseIdentifier)
        return tableView
    }()
    
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
    }
    
    // MARK: - Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        configureConstraints()
    }
    
    // MARK: - Public Methods
    public func configure(delegate: ArticlesHandler?) {
        articlesTableView.delegate = delegate
        articlesTableView.dataSource = delegate
    }
    
    // MARK: - Private Methods
    override func configureView() {
        addSubview(articlesTableView)
    }
    
    override func configureConstraints() {
        NSLayoutConstraint.activate([
            articlesTableView.topAnchor.constraint(equalTo: topAnchor),
            articlesTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            articlesTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            articlesTableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    // MARK: - Deinitialization
    deinit { print("Deinit \(String(describing: CategoryArticlesCell.self))") }
}
