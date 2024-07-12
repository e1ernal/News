//
//  NetworkService.swift
//  News
//
//  Created by e1ernal on 12.07.2024.
//

import Foundation

protocol NetworkService {
    static func getArticles(page: Int) async throws -> Articles
}

