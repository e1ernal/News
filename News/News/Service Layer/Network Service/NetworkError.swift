//
//  NetworkError.swift
//  News
//
//  Created by e1ernal on 12.07.2024.
//

import Foundation

enum NetworkError: Error {
    case decoding
    case invalidAuthorization
    case invalidStatusCode(_ statusCode: Int)
    case unknown(_ error: Error)
    
    var description: String {
        switch self {
        case .decoding:
            return "Error - Decoding"
        case .invalidAuthorization:
            return "Error - Invalid Authorisation"
        case .invalidStatusCode(let statusCode):
            return "Error - Invalid StatusCode: \(statusCode)"
        case .unknown(let error):
            return "Error - Unknown: \(error.localizedDescription)"
        }
    }
}

