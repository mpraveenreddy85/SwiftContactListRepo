//
//  NetworkHelperTests.swift
//  SwiftTestRepoTests
//
//  Created by Apple on 06/08/24.
//

import XCTest
@testable import SwiftTestRepo

class NetworkHelperTests: XCTestCase {

    func testFetchDataWithValidURL() {
        // Define an expectation for the asynchronous operation
        let expectation = self.expectation(description: "Fetch data")
        // Use a valid URL for testing
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {
            XCTFail("Invalid URL")
            return
        }

        NetworkHelper.shared.fetchData(from: url) { result in
            switch result {
            case .success(let data):
                // Verify that data was received
                XCTAssertNotNil(data)
                expectation.fulfill() // Fulfill the expectation
            case .failure(let error):
                XCTFail("Fetch data failed with error: \(error.localizedDescription)")
            }
        }

        // Wait for the expectation to be fulfilled or timeout
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testFetchDataWithInvalidURL() {
        // Define an expectation for the asynchronous operation
        let expectation = self.expectation(description: "Fetch data")
        // Use an invalid URL to simulate a failure
        guard let url = URL(string: "https://invalidurl.com") else {
            XCTFail("Invalid URL")
            return
        }

        NetworkHelper.shared.fetchData(from: url) { result in
            switch result {
            case .success(let data):
                XCTFail("Fetch data should have failed, but succeeded with data: \(data)")
            case .failure(let error):
                // Verify that an error occurred
                XCTAssertNotNil(error)
                expectation.fulfill() // Fulfill the expectation
            }
        }

        // Wait for the expectation to be fulfilled or timeout
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testFetchDataWithNoData() {
        // Define an expectation for the asynchronous operation
        let expectation = self.expectation(description: "Fetch data")
        // Use a URL that simulates an empty response
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/nodata") else {
            XCTFail("Invalid URL")
            return
        }

        NetworkHelper.shared.fetchData(from: url) { result in
            switch result {
            case .success(let data):
                // Verify that the data is empty
                XCTAssertTrue(data.isEmpty, "Expected empty data, but received data with length: \(data.count)")
                expectation.fulfill() // Fulfill the expectation
            case .failure(let error):
                XCTFail("Fetch data failed with error: \(error.localizedDescription)")
            }
        }

        // Wait for the expectation to be fulfilled or timeout
        waitForExpectations(timeout: 5, handler: nil)
    }
}
