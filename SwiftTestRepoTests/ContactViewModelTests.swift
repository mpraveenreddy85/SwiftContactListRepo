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
    var mockNetworkHelper: MockNetworkHelper!
    
    override func setUp() {
        super.setUp()
        mockNetworkHelper = MockNetworkHelper()
        viewModel = ContactViewModel(networkHelper: mockNetworkHelper)
    }
    
    override func tearDown() {
        viewModel = nil
        mockNetworkHelper = nil
        super.tearDown()
    }
    
    func testFetchContactsSuccess() {
        let mockContacts: [Contact] = [Contact(id: 1, name: "John Doe", email: "john.doe@example.com")]
        let mockData = try! JSONEncoder().encode(mockContacts)
        mockNetworkHelper.fetchContactsResult = .success(mockData)
        
        let expectation = XCTestExpectation(description: "Contacts fetched successfully")
        
        viewModel.onContactsFetched = {
            XCTAssertEqual(self.viewModel.numberOfContacts(), 1)
            let contact = self.viewModel.contact(at: 0)
            XCTAssertEqual(contact?.name, "John Doe")
            XCTAssertEqual(contact?.email, "john.doe@example.com")
            expectation.fulfill()
        }
        
        viewModel.fetchContacts()
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testFetchContactsFailure() {
        mockNetworkHelper.fetchContactsResult = .failure(NetworkError.noData)
        
        let expectation = XCTestExpectation(description: "Contacts fetch failed")
        
        viewModel.onFetchError = { error in
            XCTAssertEqual(error as? NetworkError, NetworkError.noData)
            expectation.fulfill()
        }
        
        viewModel.fetchContacts()
        
        wait(for: [expectation], timeout: 1.0)
    }
}
