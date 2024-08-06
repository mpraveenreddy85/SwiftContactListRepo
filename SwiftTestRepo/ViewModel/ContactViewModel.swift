//
//  ContactViewModel.swift
//  SwiftTestRepo
//
//  Created by Apple on 06/08/24.
//

import Foundation

class ContactViewModel {
    
    // URL endpoint for fetching contacts
    var contactsURL: String
    
    // Array to hold the fetched contacts
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
    
    /**
     Initializes the ViewModel with a given URL for fetching contacts.
     - Parameter contactsURL: The URL string to fetch contacts from. Defaults to a predefined URL.
     */
    init(contactsURL: String = Constants.URLs.contactsURL) {
        self.contactsURL = contactsURL
    }
    
    
    /// Fetches contacts from the network.
    func fetchContacts() {
        // Ensure the URL is valid
        guard let url = URL(string: contactsURL) else { return }
        
        // Use NetworkHelper to fetch data from the URL
        NetworkHelper.shared.fetchData(from: url) { [weak self] result in
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
    
    // Parameter index: The index of the contact to retrieve.
    // Returns: The Contact object at the specified index, or nil if the index is out of bounds.
    func contact(at index: Int) -> Contact? {
        guard index < contacts.count else { return nil }
        return contacts[index]
    }
}
