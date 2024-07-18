//
//  String.swift
//  News
//
//  Created by e1ernal on 12.07.2024.
//

import UIKit

public extension String {
    // MARK: - Initializers
    init(dateString: String, format: String = "yyyy-MM-dd'T'HH:mm:ssZ") {
        let date = Date(dateString: dateString, format: format)
        self = date.components(format: format)
    }
    
    /// Calculates label width with this string as text
    /// - Parameter font: label text font
    /// - Returns: width of label text
    func width(font: UIFont) -> (width: CGFloat, height: CGFloat) {
        let attributes = [NSAttributedString.Key.font: font as Any]
        let size = self.size(withAttributes: attributes)
        return (size.width, size.height)
    }
}
