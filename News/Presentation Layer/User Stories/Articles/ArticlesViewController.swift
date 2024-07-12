//
//  NewsViewController.swift
//  News
//
//  Created by e1ernal on 12.07.2024.
//

import UIKit

protocol ArticlesDisplayLogic: AnyObject {
    func display(data: [Article])
}

final class ArticlesViewController: UIViewController {
    // MARK: - Public Properties
    
    // MARK: - Private Properties
    private var interactor: ArticlesBusinessLogic?
    private var articlesView = ArticlesView()
    private var data = [Article]() {
        didSet {
            DispatchQueue.main.async {
                self.articlesView.reload()
            }
        }
    }
    
    // MARK: - Initialization
    init() {
        // Init optional properties
        super.init(nibName: nil, bundle: nil)
        configure()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interactor?.fetchArticles()
    }
    
    override func loadView() {
        self.view = articlesView
    }
    
    // MARK: - Actions
    
    // MARK: - Public Methods
    
    // MARK: - Private Methods
    private func configure() {
        navigationItem.setTitle(title: "News", subtitle: Date.current())
        navigationItem.setHidesBackButton(true, animated: true)
        
        let viewController = self
        let presenter = ArticlesPresenter()
        let interactor = ArticlesInteractor()
        
        interactor.presenter = presenter
        presenter.viewController = viewController
        viewController.interactor = interactor
        
        let cellTypes = [ArticleCell.self]
        articlesView.configure(delegate: self, dataSource: self, registerCell: cellTypes)
    }
    
    // MARK: - Deinitialization
    deinit { print("Deinit \(String(describing: ArticlesViewController.self))") }
}

// MARK: - View's Protocols implementation
extension ArticlesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { data.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(ArticleCell.self, for: indexPath)
        let row = data[indexPath.row]
        cell.configure(article: row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard indexPath.row == data.count - 1 else { return }
        guard let interactor, interactor.availableToFetch else { return }
        
        interactor.fetchArticles()
        
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.startAnimating()
        spinner.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 50)
        tableView.tableFooterView = spinner
    }
}

extension ArticlesViewController: ArticlesDisplayLogic {
    func display(data: [Article]) {
        self.data.append(contentsOf: data)
    }
}
