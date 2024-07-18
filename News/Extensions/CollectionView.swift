//
//  CollectionView.swift
//  News
//
//  Created by e1ernal on 16.07.2024.
//

import UIKit

public extension UICollectionView {
  var visibleCellIndexPath: IndexPath? {
    for cell in self.visibleCells {
      let indexPath = self.indexPath(for: cell)
      return indexPath
    }
    
    return nil
  }
}
