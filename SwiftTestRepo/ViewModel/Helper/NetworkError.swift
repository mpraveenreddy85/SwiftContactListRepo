//
//  NetworkError.swift
//  SwiftTestRepo
//
//  Created by Apple on 07/08/24.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError // Add more cases as needed
}
