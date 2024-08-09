//
//  MockNetworkHelper.swift
//  SwiftTestRepoTests
//
//  Created by Apple on 07/08/24.
//

import Foundation
import XCTest
@testable import SwiftTestRepo


// A mock implementation of the NetworkHelperProtocol used for unit testing
class MockNetworkHelper: NetworkHelperProtocol {
    
    // The result to be returned by fetchContacts and fetchData methods
    var fetchContactsResult: Result<Data, Error>?
    
    // This method simulates fetching contacts data and calls the completion handler with the predefined result
    func fetchContacts(completion: @escaping (Result<Data, Error>) -> Void) {
        // Ensure fetchContactsResult is set; if not, the method will crash
        guard let result = fetchContactsResult else {
            fatalError("fetchContactsResult must be set before calling fetchContacts")
        }
        // Call the completion handler with the stored result
        completion(result)
    }
    
    // This method simulates fetching and decoding data from a URL
    func fetchData<T: Decodable>(urlString: String, completion: @escaping (Result<T, Error>) -> Void) {
        // Ensure fetchContactsResult is set; if not, the method will crash
        guard let result = fetchContactsResult else {
            fatalError("fetchContactsResult must be set before calling fetchData")
        }
        
        // Handle the result based on whether it was a success or failure
        switch result {
        case .success(let data):
            do {
                // Attempt to decode the data into the expected type
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                // If decoding is successful, return the decoded data
                completion(.success(decodedData))
            } catch {
                // If decoding fails, return a decoding error
                completion(.failure(NetworkError.decodingError(error)))
            }
        case .failure(let error):
            // If the result is a failure, return the error
            completion(.failure(error))
        }
    }
}
