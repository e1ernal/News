//
//  Articles.swift
//  News
//
//  Created by e1ernal on 12.07.2024.
//

import Foundation

struct Articles: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}
