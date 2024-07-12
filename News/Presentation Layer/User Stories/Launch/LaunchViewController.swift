//
//  LaunchViewController.swift
//  News
//
//  Created by e1ernal on 12.07.2024.
//

import UIKit

final class LaunchViewController: UIViewController {
    // MARK: - Public Properties
    
    // MARK: - Private Properties
    private let launchView: LaunchView
    
    // MARK: - Initialization
    init() {
        // Init optional properties
        launchView = LaunchView(title: "News")
        launchView.layer.opacity = 0
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        self.view = self.launchView
        UIView.animate(withDuration: 1) {
            self.launchView.layer.opacity = 1
        } completion: { _ in
            UIView.animate(withDuration: 1) {
                self.launchView.layer.opacity = 0
            } completion: { _ in
                self.navigationController?.pushViewController(ArticlesViewController(), animated: true)
            }
        }
    }
    
    // MARK: - Actions
    
    // MARK: - Public Methods
    
    // MARK: - Private Methods
    
    // MARK: - Deinitialization
    deinit { print("Deinit \(String(describing: LaunchViewController.self))") }
}
