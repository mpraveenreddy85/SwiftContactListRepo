//
//  NetworkHelperProtocol.swift
//  SwiftTestRepo
//
//  Created by Apple on 07/08/24.
//

import Foundation

/// A protocol defining the contract for fetching contacts data.
protocol NetworkHelperProtocol {
    /// - Parameter completion: A closure that is called with the result of the fetch operation.
    func fetchContacts(completion: @escaping (Result<Data, Error>) -> Void)
}
