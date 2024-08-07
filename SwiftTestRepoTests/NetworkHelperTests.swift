//
//  NetworkHelperTests.swift
//  SwiftTestRepoTests
//
//  Created by Apple on 06/08/24.
//

import XCTest
@testable import SwiftTestRepo

class NetworkHelperTests: XCTestCase {

    func testFetchContactsSuccess() {
        // Given
        let mockContacts: [Contact] = [Contact(id: 1, name: "John Doe", email: "john.doe@example.com")]
        let mockData = try! JSONEncoder().encode(mockContacts)
        let mockNetworkHelper = MockNetworkHelper()
        mockNetworkHelper.fetchContactsResult = .success(mockData)
        
        let expectation = XCTestExpectation(description: "Fetch contacts successfully")
        
        // When
        mockNetworkHelper.fetchContacts { result in
            // Then
            switch result {
            case .success(let data):
                XCTAssertEqual(data, mockData, "Data should match mock data")
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Expected success, but got failure with error: \(error)")
            }
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testFetchContactsFailure() {
        // Given
        let mockNetworkHelper = MockNetworkHelper()
        mockNetworkHelper.fetchContactsResult = .failure(NetworkError.noData)
        
        let expectation = XCTestExpectation(description: "Fetch contacts failed")
        
        // When
        mockNetworkHelper.fetchContacts { result in
            // Then
            switch result {
            case .success:
                XCTFail("Expected failure, but got success")
            case .failure(let error):
                XCTAssertEqual(error as? NetworkError, NetworkError.noData, "Error should match NetworkError.noData")
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testFetchContactsWithEmptyData() {
        // Given
        let emptyData = "[]".data(using: .utf8)!
        let mockNetworkHelper = MockNetworkHelper()
        mockNetworkHelper.fetchContactsResult = .success(emptyData)
        
        let expectation = XCTestExpectation(description: "Fetch contacts with empty data")
        
        // When
        mockNetworkHelper.fetchContacts { result in
            // Then
            switch result {
            case .success(let data):
                XCTAssertEqual(data, emptyData, "Data should be empty but valid")
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Expected success, but got failure with error: \(error)")
            }
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testFetchContactsWithInvalidData() {
        // Given
        let invalidData = "{\"invalid\": \"data\"}".data(using: .utf8)!
        let mockNetworkHelper = MockNetworkHelper()
        mockNetworkHelper.fetchContactsResult = .success(invalidData)
        
        let expectation = XCTestExpectation(description: "Fetch contacts with invalid data")
        
        // When
        mockNetworkHelper.fetchContacts { result in
            // Then
            switch result {
            case .success(let data):
                XCTAssertEqual(data, invalidData, "Data should be invalid but received")
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Expected success, but got failure with error: \(error)")
            }
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
}
