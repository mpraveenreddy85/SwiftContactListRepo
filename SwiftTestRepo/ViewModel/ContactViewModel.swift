//
//  ContactViewModel.swift
//  SwiftTestRepo
//
//  Created by Apple on 06/08/24.
//

import Foundation

class ContactViewModel {
    
    /// An instance of `NetworkHelperProtocol` to fetch contacts data.
    private let networkHelper: NetworkHelperProtocol
    
    /// An array of `Contact` objects representing the fetched contacts.
    var contacts: [Contact] = [] {
        didSet {
            // Notify that contacts have been fetched whenever the contacts property is updated
            DispatchQueue.main.async {
                self.onContactsFetched?()
            }
        }
    }
    
    // Closure that gets called when contacts are successfully fetched
    var onContactsFetched: (() -> Void)?
    
    // Closure that gets called when there's an error fetching contacts
    var onFetchError: ((Error) -> Void)?
    
    // Initializes the `ContactViewModel` with a given `NetworkHelperProtocol`.
    // - Parameter networkHelper: The `NetworkHelperProtocol` instance to use for fetching contacts. Defaults to `NetworkHelper.shared`.
    init(networkHelper: NetworkHelperProtocol = NetworkHelper.shared) {
        self.networkHelper = networkHelper
    }
    
    // Generic fetch method to fetch and decode any type of data from the network.
    // - Parameters:
    //   - urlString: The URL string from which to fetch data.
    //   - completion: A closure that is called with the result of the fetch operation, containing either the decoded data or an error.
    func fetch<T: Decodable>(urlString: String, completion: @escaping (Result<T, Error>) -> Void) {
        networkHelper.fetchData(urlString: urlString, completion: completion)
    }
    
    /// Fetches contacts from the network.
    func fetchContacts() {
        fetch(urlString: Constants.URLs.contactsURL) { [weak self] (result: Result<[Contact], Error>) in
            switch result {
            case .success(let decodedContacts):
                // Update the contacts property, which will trigger the onContactsFetched closure
                self?.contacts = decodedContacts
            case .failure(let error):
                // If the network request fails, trigger the onFetchError closure with the error
                self?.onFetchError?(error)
            }
        }
    }
    
    // Returns the number of contacts in the list.
    func numberOfContacts() -> Int {
        return contacts.count
    }
    
    // Retrieves a contact at a specific index.
    // - Parameter index: The index of the contact to retrieve.
    // - Returns: The `Contact` object at the specified index, or nil if the index is out of bounds.
    func contact(at index: Int) -> Contact? {
        guard index < contacts.count else { return nil }
        return contacts[index]
    }
}
