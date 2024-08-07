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
    
    func fetchContacts(completion: @escaping (Result<Data, Error>) -> Void) {
        if let result = fetchContactsResult {
            completion(result)
        }
    }
}

