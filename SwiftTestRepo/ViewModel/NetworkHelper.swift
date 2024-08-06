//
//  NetworkHelper.swift
//  SwiftTestRepo
//
//  Created by Apple on 06/08/24.
//

import Foundation

/// A singleton class for handling network requests.
class NetworkHelper {
    
    // Shared instance for global use
    static let shared = NetworkHelper()
    
    // Private initializer to prevent multiple instances
    private init() {}
    
    
    // Parameter completion: A closure called with the result of the fetch operation
    
    func fetchData(from url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        // Create a data task to fetch data from the URL
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                // Return an error if one occurred
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                // Return an error if no data was received
                let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: Constants.Errors.noDataReceived])
                completion(.failure(error))
                return
            }
            
            // Return the fetched data
            completion(.success(data))
        }
        
        // Start the data task
        task.resume()
    }
}

