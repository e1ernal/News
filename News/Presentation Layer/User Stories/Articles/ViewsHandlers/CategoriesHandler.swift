//
//  CategoriesDataSource.swift
//  News
//
//  Created by e1ernal on 17.07.2024.
//

import UIKit

final class CategoriesHandler: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    // MARK: - Public Properties
    public var source: [String]
    
    // MARK: - Private Properties
    private weak var delegate: ArticleViewEventsProtocol?
    private let font = UIFont.systemFont(ofSize: 15, weight: .bold)
    private let spacing: CGFloat = 7
    
    // MARK: - Initialization
    init(source: [String] = [], delegate: ArticleViewEventsProtocol?) {
        self.source = source
        self.delegate = delegate
    }
    
    // MARK: - Public Methods
    func update(source: [String]) {
        self.source = source
    }
    
    // UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, 
                        numberOfItemsInSection section: Int) -> Int {
        return source.count
    }
    
    func collectionView(_ collectionView: UICollectionView, 
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(CategoryCell.self, for: indexPath)
        cell.configure(text: source[indexPath.row])
        return cell
    }
    
    // UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectItemAt(indexPath: indexPath)
    }
    
    // UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let labelSize = source[indexPath.row].width(font: font)
        return CGSize(width: labelSize.width + 2 * spacing, height: labelSize.height + 2 * spacing)
    }
}
