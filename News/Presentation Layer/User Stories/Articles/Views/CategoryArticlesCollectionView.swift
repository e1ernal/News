//
//  CategoriesCollectionView.swift
//  News
//
//  Created by e1ernal on 16.07.2024.
//

import UIKit



final class CategoryArticlesCollectionView: UICollectionView, UICollectionViewDelegateFlowLayout {
    // MARK: - Public Properties

    // MARK: - Private Properties
    private let categoriesLayout = UICollectionViewFlowLayout()
    
    // MARK: - Initialization
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: categoriesLayout)
        
        configure()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    // MARK: - Private Methods
    // Configuration
    private func configure() {
        // Configure Collection View
        showsHorizontalScrollIndicator = false
        translatesAutoresizingMaskIntoConstraints = false
        isPagingEnabled = true
        
        // Configure Layout
        categoriesLayout.minimumLineSpacing = 0
        categoriesLayout.scrollDirection = .horizontal
        
        register(CategoryArticlesCell.self, forCellWithReuseIdentifier: CategoryArticlesCell.reuseIdentifier)
    }
    
    // MARK: - Deinitialization
    deinit { print("Deinit \(String(describing: CategoriesCollectionView.self))") }
}
