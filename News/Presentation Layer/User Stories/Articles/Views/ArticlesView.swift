//
//  NewsView.swift
//  News
//
//  Created by e1ernal on 12.07.2024.
//

import UIKit

protocol ArticleViewEventsProtocol: AnyObject {
    func didSelectItemAt(indexPath: IndexPath)
    func willDisplayItemAt(indexPath: IndexPath, category: String)
}

protocol ArticlesViewProtocol: UIView {
    func updateArticles(in category: String, with articles: [Article])
    func updateData(data: [String: [Article]]?)
}

final class ArticlesView: UIView, ArticlesViewProtocol, ArticleViewEventsProtocol {
    // MARK: - Public Properties
    
    // MARK: - Private Properties
    private weak var controller: ArticlesViewHandleEventsProtocol?
    private var categories: [String]? {
        self.data?.map { $0.key }
    }
    
    private var data: [String: [Article]]? {
        didSet {
            DispatchQueue.main.async {
                if self.categoriesHandler?.source != self.categories ?? [] {
                    self.categoriesHandler?.update(source: self.categories ?? [])
                    self.categoriesView.reloadData()
                }
                
                self.categoryArticlesHandler?.update(source: self.data ?? [:])
                self.categoryArticlesView.reloadData()
            }
        }
    }
    
    private let categoriesView = CategoriesCollectionView()
    private var categoriesHandler: CategoriesHandler?
    
    private let categoryArticlesView = CategoryArticlesCollectionView()
    private var categoryArticlesHandler: CategoryArticlesHandler?

    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Set delegates & data sources
        categoriesHandler = CategoriesHandler(delegate: self)
        categoriesView.dataSource = categoriesHandler
        categoriesView.delegate = categoriesHandler

        categoryArticlesHandler = CategoryArticlesHandler(delegate: self)
        categoryArticlesView.dataSource = categoryArticlesHandler
        categoryArticlesView.delegate = categoryArticlesHandler

        // Configure View
        addSubview(categoriesView)
        addSubview(categoryArticlesView)
//        backgroundColor = .systemBackground
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(delegate: ArticlesViewHandleEventsProtocol) {
        self.init(frame: .zero)
        self.controller = delegate
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
            
            categoryArticlesView.topAnchor.constraint(equalTo: categoriesView.bottomAnchor),
            categoryArticlesView.bottomAnchor.constraint(equalTo: bottomAnchor),
            categoryArticlesView.leadingAnchor.constraint(equalTo: leadingAnchor),
            categoryArticlesView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    // MARK: - Public Methods
    // ArticlesViewProtocol
    func updateArticles(in category: String, with articles: [Article]) {
        self.data?[category] = articles
    }
    
    func updateData(data: [String: [Article]]?) {
        self.data = data
    }
    
    // ArticleViewEventsProtocol
    func didSelectItemAt(indexPath: IndexPath) {
        categoriesView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        categoriesView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        categoryArticlesView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
        guard let data, let categories else { return }
        if data[categories[indexPath.row]] != nil {
            controller?.fetch(category: categories[indexPath.row])
        }
    }
    
    func willDisplayItemAt(indexPath: IndexPath, category: String) {
        controller?.fetchMore(category: category)
    }
    
////    func configure(
////        delegate: UITableViewDelegate,
////        dataSource: UITableViewDataSource,
////        registerCell: [TableViewCell.Type]
////    ) {
////        articlesByCategoryTableView.delegate = delegate
////        articlesByCategoryTableView.dataSource = dataSource
////        registerCell.forEach { articlesByCategoryTableView.register($0, forCellReuseIdentifier: $0.reuseIdentifier) }
////    }
//    
//    func reload() {
//        
//    }
//    
//    func reload(row: Int, in section: Int) {
////        let numberOfSections = articlesByCategoryTableView.numberOfSections
////        guard 0...numberOfSections ~= section else { return }
////        let numberOfRows = articlesByCategoryTableView.numberOfRows(inSection: section)
////        guard 0...numberOfRows ~= row else { return }
////        let indexPath = IndexPath(row: row, section: section)
////        
////        UIView.transition(
////            with: articlesByCategoryTableView,
////            duration: 0.3,
////            options: .curveEaseInOut,
////            animations: {
////                self.articlesByCategoryTableView.reloadRows(at: [indexPath], with: .none)
////            }, completion: nil
////        )
//    }
    
    // MARK: - Private Methods
    
    // MARK: - Deinitialization
    deinit { print("Deinit \(String(describing: ArticlesView.self))") }
}
