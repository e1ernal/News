//
//  ArticlesHandler.swift
//  News
//
//  Created by e1ernal on 17.07.2024.
//

import UIKit

final class ArticlesHandler: NSObject, UITableViewDataSource, UITableViewDelegate {
    // MARK: - Public Properties
    
    // MARK: - Private Properties
    private var source: [Article]
    private var category: String
    private weak var delegate: ArticleViewEventsProtocol?
    
    // MARK: - Initialization
    init(source: [Article], category: String, delegate: ArticleViewEventsProtocol?) {
        self.source = source
        self.category = category
        self.delegate = delegate
    }
    
    // MARK: - Public Methods
    func update(source: [Article]) {
        self.source = source
    }
    
    // UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return source.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(ArticleCell.self, for: indexPath)
        let row = source[indexPath.row]
        cell.configure(article: row)
        return cell
    }
    
    // UITableViewDelegate
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        delegate?.willDisplayItemAt(indexPath: indexPath, category: category)
    }
    
    // MARK: - Private Methods
    
    // MARK: - Deinitialization
    deinit { print("Deinit \(String(describing: ArticlesHandler.self))") }
}
