//
//  String.swift
//  News
//
//  Created by e1ernal on 12.07.2024.
//

import Foundation

extension String {
    // MARK: - Initializers
    init(dateString: String, format: String) {
        let date = Date(dateString: dateString, format: "yyyy-MM-dd'T'HH:mm:ssZ")
        self = date.components(format: format)
    }
}
