//
//  UITableView+deque.swift
//  News
//
//  Created by e1ernal on 12.07.2024.
//

import UIKit

extension UITableView {
    func dequeue<T: UITableViewCell & Reusable>(_ cellType: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier,
                                             for: indexPath) as? T else {
            preconditionFailure("Could not dequeue cell: \(T.reuseIdentifier)")
        }
        return cell
    }
}

