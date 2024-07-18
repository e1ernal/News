//
//  NewsViewController.swift
//  News
//
//  Created by e1ernal on 12.07.2024.
//

import UIKit

protocol ArticlesViewControllerPresentProtocol: AnyObject {
    func present(data: [Article], category: String)
}

protocol ArticlesViewHandleEventsProtocol: AnyObject {
    func fetch(category: String)
    func fetchMore(category: String)
}

final class ArticlesViewController: UIViewController, ArticlesViewControllerPresentProtocol, ArticlesViewHandleEventsProtocol {
    // MARK: - Public Properties
    
    // MARK: - Private Properties
    private var data: [String: [Article]] = [:] {
        didSet { articlesView?.updateData(data: data) }
    }
    
    private var interactor: ArticlesInteractorProtocol?
    private var articlesView: ArticlesViewProtocol?
        
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

        let categories = interactor?.categories
        categories?.forEach { data[$0] = [] }
        interactor?.fetch(category: "Health")
    }
    
    override func loadView() {
        self.view = articlesView
    }
    
    // MARK: - Actions
    
    // MARK: - Public Methods
    // ArticlesViewControllerHandleViewEvents
    func fetch(category: String) {
        interactor?.fetch(category: category)
    }
    
    func fetchMore(category: String) {
        interactor?.fetchMore(category: category)
    }
   
    // ArticlesDisplayLogic Protocol
    func present(data: [Article], category: String) {
        guard let existedData = self.data[category] else {
            self.data[category] = data
            return
        }
        self.data[category] = existedData + data
        print("Stopped")
    }
    
    // MARK: - Private Methods
    private func configure() {
        navigationItem.setTitle(title: "News", subtitle: Date.current())
        navigationItem.setHidesBackButton(true, animated: true)
        
        let viewController = self
        let presenter = ArticlesPresenter(viewController: viewController)
        let interactor = ArticlesInteractor(presenter: presenter)
        viewController.interactor = interactor
        
        articlesView = ArticlesView(delegate: viewController)
    }
    
    // MARK: - Deinitialization
    deinit { print("Deinit \(String(describing: ArticlesViewController.self))") }
}
