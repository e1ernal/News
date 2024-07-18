//
//  NewsInteractor.swift
//  News
//
//  Created by e1ernal on 12.07.2024.
//

import Foundation

protocol ArticlesInteractorProtocol {
    var categories: [String] { get }
    func fetch(category: String)
    func fetchMore(category: String)
}

final class ArticlesInteractor: ArticlesInteractorProtocol {
    // MARK: - Public Properties
    public var categories: [String] { ArticlesNetworkService.categories }
    
    // MARK: - Private Properties
    private var presenter: ArticlesPresenterProtocol
    private var page: Int = 0
    private var isFetching = false
    private var fetchedAll = false
    
    // MARK: - Initialization
    init(presenter: ArticlesPresenterProtocol) {
        self.presenter = presenter
    }
    
    // MARK: - Public Methods
    // ArticlesInteractorProtocol
    func fetch(category: String) {
        Task {
            print("Fetching")
            do {
                let articles = try await ArticlesNetworkService.getArticles(category: category, page: 1)
                presenter.prepare(data: articles.articles, category: category)
            } catch let error as NetworkError {
                print(error.description)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchMore(category: String) {
        
    }
    
    //    var availableToFetch: Bool { !isFetching && !fetchedAll }
    //
    //    func fetchArticles() {
    //        guard availableToFetch else { return }
    //
    //        isFetching = true
    //        page += 1
    //        Task {
    //            do {
    //                let articles = try await ArticlesNetworkService.getArticles(page: page)
    //                isFetching = false
    //                if articles.articles.isEmpty { fetchedAll = true }
    //                presenter.present(data: articles.articles)
    //            } catch let error as NetworkError {
    //                print(error.description)
    //            } catch {
    //                print(error.localizedDescription)
    //            }
    //        }
    //    }
    
    // MARK: - Private Methods
    
    // MARK: - Deinitialization
    deinit { print("Deinit \(String(describing: ArticlesInteractor.self))") }
}

