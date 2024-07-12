//
//  NewsInteractor.swift
//  News
//
//  Created by e1ernal on 12.07.2024.
//

import Foundation

protocol ArticlesBusinessLogic {
    var availableToFetch: Bool { get }
    
    func fetchArticles()
}

final class ArticlesInteractor {
    // MARK: - Public Properties
    var presenter: ArticlesPresentationLogic?
    
    // MARK: - Private Properties
    private var page: Int = 0
    private var isFetching = false
    private var fetchedAll = false
    
    // MARK: - Initialization
    
    // MARK: - Public Methods
    
    // MARK: - Private Methods
    
    // MARK: - Deinitialization
    deinit { print("Deinit \(String(describing: ArticlesInteractor.self))") }
}

// MARK: - Business Logic
extension ArticlesInteractor: ArticlesBusinessLogic {
    var availableToFetch: Bool { !isFetching && !fetchedAll }
    
    func fetchArticles() {
        guard availableToFetch else { return }
        
        isFetching = true
        page += 1
        Task {
            do {
                let articles = try await ArticlesNetworkService.getArticles(page: page)
                isFetching = false
                if articles.articles.isEmpty { fetchedAll = true }
                presenter?.present(data: articles.articles)
            } catch let error as NetworkError {
                print(error.description)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

