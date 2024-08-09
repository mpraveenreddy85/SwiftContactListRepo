//
//  NetworkError.swift
//  SwiftTestRepo
//
//  Created by Apple on 07/08/24.
//

import Foundation

import Foundation

enum NetworkError: Error, Equatable {
    case invalidURL
    case noData
    case decodingError(Error)

    static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidURL, .invalidURL),
             (.noData, .noData):
            return true
        case (.decodingError(let lhsError), .decodingError(let rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        default:
            return false
        }
    }
}
