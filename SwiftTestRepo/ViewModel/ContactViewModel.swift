//
//  ContactViewModel.swift
//  SwiftTestRepo
//
//  Created by Apple on 06/08/24.
//

import Foundation

/// A view model class responsible for managing contacts data.
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
    
    /// Initializes the `ContactViewModel` with a given `NetworkHelperProtocol`.
    /// - Parameter networkHelper: The `NetworkHelperProtocol` instance to use for fetching contacts. Defaults to `NetworkHelper.shared`.
    init(networkHelper: NetworkHelperProtocol = NetworkHelper.shared) {
        self.networkHelper = networkHelper
    }
    
    
    /// Fetches contacts from the network.
    func fetchContacts() {
        networkHelper.fetchContacts { [weak self] result in
            switch result {
            case .success(let data):
                do {
                    // Decode the data into an array of Contact objects
                    let decodedContacts = try JSONDecoder().decode([Contact].self, from: data)
                    // Update the contacts property, which will trigger the onContactsFetched closure
                    self?.contacts = decodedContacts
                } catch {
                    // If decoding fails, trigger the onFetchError closure with the error
                    self?.onFetchError?(error)
                }
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
    
    /// Retrieves a contact at a specific index.
    /// index: The index of the contact to retrieve.
    /// The `Contact` object at the specified index, or nil if the index is out of bounds.
    func contact(at index: Int) -> Contact? {
        guard index < contacts.count else { return nil }
        return contacts[index]
    }
}
