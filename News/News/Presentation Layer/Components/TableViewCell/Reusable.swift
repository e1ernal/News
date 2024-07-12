//
//  Reusable.swift
//  News
//
//  Created by e1ernal on 12.07.2024.
//

import UIKit

protocol Reusable: AnyObject {
    static var reuseIdentifier: String { get }
}

extension Reusable where Self: UIView {
    static var reuseIdentifier: String { String(describing: self) }
}
