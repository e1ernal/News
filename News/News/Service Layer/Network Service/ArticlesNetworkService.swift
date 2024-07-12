//
//  ArticlesNetworkService.swift
//  News
//
//  Created by e1ernal on 12.07.2024.
//

import UIKit

final class ArticlesNetworkService: NetworkService {
    // MARK: - Public Properties
    
    // MARK: - Private Properties
    private static let decoder = JSONDecoder()
    private let session: URLSession
    
    // MARK: - Initialization
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    // MARK: - Public Methods
    static func getImage(urlString: String?) async -> UIImage? {
        guard let urlString, let url = URL(string: urlString) else { return nil }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return UIImage(data: data)
        } catch { return nil }
    }
    
    static func getArticles(page: Int) async throws -> Articles {
        let urlString = "https:/"
            + "/newsapi.org/v2/"
            + "top-headlines?"
            + "country=us"
            + "&pageSize=10"
            + "&page=\(page)"
            + "&apiKey=ae2e869be22d46ba9da27505e8f80e36"
//            + "&apiKey=41352c89c2b84d4297a9b8d108f2cfbb"
        
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidAuthorization
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("ae2e869be22d46ba9da27505e8f80e36", forHTTPHeaderField: "apiKey")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let code = (response as? HTTPURLResponse)?.statusCode else {
            throw NetworkError.invalidAuthorization
        }
        
        guard code == 200 else {
            throw NetworkError.invalidStatusCode(code)
        }
        
        do {
            return try Self.decoder.decode(Articles.self, from: data)
        } catch {
            throw NetworkError.decoding
        }
    }
    // MARK: - Private Methods
}
