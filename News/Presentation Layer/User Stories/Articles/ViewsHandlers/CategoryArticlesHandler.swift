//
//  CategoriesHandler.swift
//  News
//
//  Created by e1ernal on 17.07.2024.
//

import UIKit

final class CategoryArticlesHandler: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    // MARK: - Public Properties
    public var source: [String: [Article]]
    
    // MARK: - Private Properties
    private weak var delegate: ArticleViewEventsProtocol?
    private var handlers: [ArticlesHandler] = []
    
    // MARK: - Initialization
    init(source: [String: [Article]] = [:], delegate: ArticleViewEventsProtocol) {
        self.source = source
        self.delegate = delegate
    }
    
    // MARK: - Public Methods
    func update(source: [String: [Article]]) {
        self.source = source
    }
    
    // UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return source.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(CategoryArticlesCell.self, for: indexPath)
        let categories = source.map { $0.key }
        let category = categories[indexPath.row]
        let handler = ArticlesHandler(source: source[category] ?? [], category: category, delegate: delegate)
        handlers.append(handler)
        cell.configure(delegate: handler)
        return cell
    }
    
    // UICollectionViewDelegate
    func scrollViewWillEndDragging(_ scrollView: UIScrollView,
                                   withVelocity velocity: CGPoint,
                                   targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = Int(targetContentOffset.pointee.x / scrollView.frame.width)
        let indexPath = IndexPath(item: index, section: 0)
        delegate?.didSelectItemAt(indexPath: indexPath)
    }
    
    // UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}
