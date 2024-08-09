//
//  NetworkHelperProtocol.swift
//  SwiftTestRepo
//
//  Created by Apple on 07/08/24.
//

import Foundation

protocol NetworkHelperProtocol {
 
    // Fetches and decodes data from the network.
    // - Parameters:
    //   - urlString: The URL string from which to fetch data.
    //   - completion: A closure that is called with the result of the fetch operation, containing either the decoded data or an error.
    func fetchData<T: Decodable>(urlString: String, completion: @escaping (Result<T, Error>) -> Void)
}
