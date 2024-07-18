//
//  NewsPresenter.swift
//  News
//
//  Created by e1ernal on 12.07.2024.
//

import UIKit

protocol ArticlesPresenterProtocol {
    func prepare(data: [Article], category: String)
}

final class ArticlesPresenter: ArticlesPresenterProtocol {
    // MARK: - Public Properties
    
    // MARK: - Private Properties
    private weak var viewController: ArticlesViewControllerPresentProtocol?
    
    // MARK: - Initialization
    init(viewController: ArticlesViewControllerPresentProtocol) {
        self.viewController = viewController
    }
    
    // MARK: - Public Methods
    // ArticlesPresenterProtocol
    func prepare(data: [Article], category: String) {
        let articles = data
            .filter {
                $0.title != "[Removed]" &&
                $0.description != "[Removed]"
            }
            .enumerated()
            .map { _, article in
                return Article(
                    source: article.source,
                    author: article.author == nil || article.author == "" ? nil : "By \(article.author ?? "")",
                    title: article.title,
                    description: article.description,
                    url: article.url,
                    urlToImage: article.urlToImage,
                    publishedAt: String(dateString: article.publishedAt, format: "d MMM, h:mm a"),
                    content: article.content
                )
            }
        viewController?.present(data: articles, category: category)
    }
    // MARK: - Private Methods
    
    // MARK: - Deinitialization
    deinit { print("Deinit \(String(describing: ArticlesPresenter.self))") }
}
