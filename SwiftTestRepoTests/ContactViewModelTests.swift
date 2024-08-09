//
//  ContactViewModelTests.swift
//  SwiftTestRepoTests
//
//  Created by Apple on 06/08/24.
//

import XCTest
@testable import SwiftTestRepo

class ContactViewModelTests: XCTestCase {

    // Instance variables for the view model and the mock network helper
    var viewModel: ContactViewModel!
    var mockNetworkHelper: MockNetworkHelper!
    
    // Setup method that is called before each test method is invoked
    override func setUp() {
        super.setUp()
        // Initialize the mock network helper and view model
        mockNetworkHelper = MockNetworkHelper()
        viewModel = ContactViewModel(networkHelper: mockNetworkHelper)
    }
    
    // Teardown method that is called after each test method is invoked
    override func tearDown() {
        // Clean up the view model and mock network helper
        viewModel = nil
        mockNetworkHelper = nil
        super.tearDown()
    }
    
    // Test case to verify that contacts are fetched successfully
    func testFetchContactsSuccess() {
        // Given: Prepare mock contacts data and encode it to JSON
        let mockContacts: [Contact] = [Contact(id: 1, name: "John Doe", email: "john.doe@example.com")]
        let mockData = try! JSONEncoder().encode(mockContacts)
        // Set the mock network helper to return success with the mock data
        mockNetworkHelper.fetchContactsResult = .success(mockData)
        
        // Define an expectation to wait for the asynchronous fetch operation
        let expectation = XCTestExpectation(description: "Contacts fetched successfully")
        
        // When: Fetch contacts using the view model
        viewModel.onContactsFetched = {
            // Then: Verify the contacts data and UI updates
            XCTAssertEqual(self.viewModel.numberOfContacts(), 1, "The number of contacts should be 1")
            let contact = self.viewModel.contact(at: 0)
            XCTAssertEqual(contact?.name, "John Doe", "The contact's name should be 'John Doe'")
            XCTAssertEqual(contact?.email, "john.doe@example.com", "The contact's email should be 'john.doe@example.com'")
            // Fulfill the expectation to indicate that the async operation is complete
            expectation.fulfill()
        }
        
        // Trigger the fetch operation
        viewModel.fetchContacts()
        
        // Wait for the expectation to be fulfilled, or time out after 1 second
        wait(for: [expectation], timeout: 1.0)
    }
    
    // Test case to verify that fetching contacts fails correctly
    func testFetchContactsFailure() {
        // Given: Set the mock network helper to return a failure
        mockNetworkHelper.fetchContactsResult = .failure(NetworkError.noData)
        
        // Define an expectation to wait for the asynchronous fetch operation
        let expectation = XCTestExpectation(description: "Contacts fetch failed")
        
        // When: Fetch contacts using the view model
        viewModel.onFetchError = { error in
            // Then: Verify that the error returned is the expected failure
            XCTAssertEqual(error as? NetworkError, NetworkError.noData, "The error should be NetworkError.noData")
            // Fulfill the expectation to indicate that the async operation is complete
            expectation.fulfill()
        }
        
        // Trigger the fetch operation
        viewModel.fetchContacts()
        
        // Wait for the expectation to be fulfilled, or time out after 1 second
        wait(for: [expectation], timeout: 1.0)
    }
}

