//
//  NetworkHelper.swift
//  SwiftTestRepo
//
//  Created by Apple on 06/08/24.
//

import Foundation

/// A singleton class responsible for fetching contacts data from a network source.
class NetworkHelper: NetworkHelperProtocol {
    /// The shared instance of `NetworkHelper`.
    static let shared = NetworkHelper()
    
    /// Private initializer to ensure singleton usage.
    private init() {}
    
    /// Fetches contacts data from the predefined URL.
    /// - Parameter completion: A closure that is called with the result of the fetch operation, containing either the fetched data or an error.
    func fetchContacts(completion: @escaping (Result<Data, Error>) -> Void) {
        // Ensure the URL is valid
        guard let url = URL(string: Constants.URLs.contactsURL) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        // Create a data task to fetch data from the URL
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                // If there's an error, pass it to the completion handler
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                // If no data is returned, pass a noData error to the completion handler
                completion(.failure(NetworkError.noData))
                return
            }
            
            // Pass the fetched data to the completion handler
            completion(.success(data))
        }
        // Start the data task
        task.resume()
    }
}

/// Errors that can occur while fetching data.
enum NetworkError: Error {
    case invalidURL  // The URL is invalid
    case noData      // No data was returned from the request
}
