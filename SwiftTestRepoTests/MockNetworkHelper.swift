//
//  MockNetworkHelper.swift
//  SwiftTestRepoTests
//
//  Created by Apple on 07/08/24.
//

import Foundation
@testable import SwiftTestRepo

class MockNetworkHelper: NetworkHelperProtocol {
    var fetchContactsResult: Result<Data, Error>?
    var fetchDataResult: Result<Data, Error>?
    
    func fetchContacts(completion: @escaping (Result<Data, Error>) -> Void) {
        if let result = fetchContactsResult {
            completion(result)
        }
    }
    
    // Implement the required method from NetworkHelperProtocol
    func fetchData<T: Decodable>(urlString: String, completion: @escaping (Result<T, Error>) -> Void) {
        // Use the fetchDataResult for mock responses
        if let result = fetchDataResult {
            switch result {
            case .success(let data):
                do {
                    // Decode data into the expected type T
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
