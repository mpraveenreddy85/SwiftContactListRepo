//
//  ContactViewModelTests.swift
//  SwiftTestRepoTests
//
//  Created by Apple on 06/08/24.
//

import XCTest
@testable import SwiftTestRepo

class ContactViewModelTests: XCTestCase {

    var viewModel: ContactViewModel!

    override func setUp() {
        super.setUp()
        // Initialize the ViewModel with a valid URL for the default setup
        viewModel = ContactViewModel(contactsURL: Constants.URLs.contactsURL)
    }

    override func tearDown() {
        // Clean up resources
        viewModel = nil
        super.tearDown()
    }

    func testFetchContactsSuccess() {
        // Define an expectation for the asynchronous operation
        let expectation = self.expectation(description: "Fetch contacts")
        
        // Set the closure to be called when contacts are successfully fetched
        viewModel.onContactsFetched = {
            // Check that the number of contacts matches the expected value
            XCTAssertEqual(self.viewModel.numberOfContacts(), 2) // Adjust based on expected number of contacts
            expectation.fulfill() // Fulfill the expectation
        }
        
        // Set the closure to be called if there is an error
        viewModel.onFetchError = { error in
            XCTFail("Fetch contacts failed with error: \(error.localizedDescription)")
        }
        
        // Trigger the fetch operation
        viewModel.fetchContacts()
        
        // Wait for the expectation to be fulfilled or timeout
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testFetchContactsFailure() {
        // Define an expectation for the asynchronous operation
        let expectation = self.expectation(description: "Fetch contacts")
        // Use an invalid URL to simulate a failure
        viewModel = ContactViewModel(contactsURL: "https://invalidurl.com")
        
        // Set the closure to be called when contacts are successfully fetched (should not happen here)
        viewModel.onContactsFetched = {
            XCTFail("Fetch contacts should have failed")
        }
        
        // Set the closure to be called if there is an error
        viewModel.onFetchError = { error in
            // Verify that an error occurred
            XCTAssertNotNil(error)
            expectation.fulfill() // Fulfill the expectation
        }
        
        // Trigger the fetch operation
        viewModel.fetchContacts()
        
        // Wait for the expectation to be fulfilled or timeout
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testFetchContactsEmptyResponse() {
        // Define an expectation for the asynchronous operation
        let expectation = self.expectation(description: "Fetch contacts")
        // Use a URL that returns an empty response
        viewModel = ContactViewModel(contactsURL: "https://jsonplaceholder.typicode.com/empty")
        
        // Set the closure to be called when contacts are successfully fetched
        viewModel.onContactsFetched = {
            // Verify that no contacts are returned
            XCTAssertEqual(self.viewModel.numberOfContacts(), 0)
            expectation.fulfill() // Fulfill the expectation
        }
        
        // Set the closure to be called if there is an error
        viewModel.onFetchError = { error in
            XCTFail("Fetch contacts failed with error: \(error.localizedDescription)")
        }
        
        // Trigger the fetch operation
        viewModel.fetchContacts()
        
        // Wait for the expectation to be fulfilled or timeout
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testFetchContactsInvalidJSON() {
        // Define an expectation for the asynchronous operation
        let expectation = self.expectation(description: "Fetch contacts")
        // Use a URL that returns invalid JSON
        viewModel = ContactViewModel(contactsURL: "https://jsonplaceholder.typicode.com/invalidjson")
        
        // Set the closure to be called when contacts are successfully fetched (should not happen here)
        viewModel.onContactsFetched = {
            XCTFail("Fetch contacts should have failed")
        }
        
        // Set the closure to be called if there is an error
        viewModel.onFetchError = { error in
            // Verify that an error occurred
            XCTAssertNotNil(error)
            expectation.fulfill() // Fulfill the expectation
        }
        
        // Trigger the fetch operation
        viewModel.fetchContacts()
        
        // Wait for the expectation to be fulfilled or timeout
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testFetchContactsNetworkTimeout() {
        // Define an expectation for the asynchronous operation
        let expectation = self.expectation(description: "Fetch contacts")
        // Use a URL that simulates a network timeout
        viewModel = ContactViewModel(contactsURL: "https://jsonplaceholder.typicode.com/timeout")
        
        // Set the closure to be called when contacts are successfully fetched (should not happen here)
        viewModel.onContactsFetched = {
            XCTFail("Fetch contacts should have failed")
        }
        
        // Set the closure to be called if there is an error
        viewModel.onFetchError = { error in
            // Verify that an error occurred
            XCTAssertNotNil(error)
            expectation.fulfill() // Fulfill the expectation
        }
        
        // Trigger the fetch operation
        viewModel.fetchContacts()
        
        // Wait for the expectation to be fulfilled or timeout
        waitForExpectations(timeout: 5, handler: nil)
    }
}
