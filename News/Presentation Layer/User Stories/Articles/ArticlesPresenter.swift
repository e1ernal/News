//
//  NewsPresenter.swift
//  News
//
//  Created by e1ernal on 12.07.2024.
//

import UIKit

protocol ArticlesPresentationLogic {
    func present(data: [Article])
}

final class ArticlesPresenter {
    // MARK: - Public Properties
    weak var viewController: ArticlesDisplayLogic?
    
    // MARK: - Private Properties
    
    // MARK: - Initialization
    
    // MARK: - Public Methods
    
    // MARK: - Private Methods
    
    // MARK: - Deinitialization
    deinit { print("Deinit \(String(describing: ArticlesPresenter.self))") }
}

// MARK: - Presentation Logic
extension ArticlesPresenter: ArticlesPresentationLogic {
    func present(data: [Article]) {
        let articles = data
            .filter {
                $0.title != "[Removed]" &&
                $0.description != "[Removed]"
            }
            .enumerated()
            .map { _, article in
                return Article(
                    source: article.source,
                    author: article.author == nil ? nil : "By \(article.author ?? "")",
                    title: article.title,
                    description: article.description,
                    url: article.url,
                    urlToImage: article.urlToImage,
                    publishedAt: String(dateString: article.publishedAt, format: "d MMM, h:mm a"),
                    content: article.content
                )
            }
        viewController?.display(data: articles)
    }
}
