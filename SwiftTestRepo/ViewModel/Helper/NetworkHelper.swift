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
    
    
    /// Fetches and decodes data from the specified URL.
    /// - Parameters:
    ///   - urlString: The URL string from which to fetch data.
    ///   - completion: A closure that is called with the result of the fetch operation, containing either the decoded data or an error.
    func fetchData<T: Decodable>(urlString: String, completion: @escaping (Result<T, Error>) -> Void) {
        // Ensure the URL is valid
        guard let url = URL(string: urlString) else {
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
            
            do {
                // Decode the data into the specified type
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                // Pass the decoded data to the completion handler
                completion(.success(decodedData))
            } catch {
                // If decoding fails, pass the error to the completion handler
                completion(.failure(error))
            }
        }
        // Start the data task
        task.resume()
    }
}
