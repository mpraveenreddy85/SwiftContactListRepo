//
//  ContactViewModel.swift
//  SwiftTestRepo
//
//  Created by Apple on 06/08/24.
//

import Foundation

class ContactViewModel {
    // Array to store the fetched contacts
    var contacts: [Contact] = [] {
        didSet {
            // Notify the view on the main thread whenever contacts are updated
            DispatchQueue.main.async {
                self.onContactsFetched?()
            }
        }
    }
    
    // Callback to notify the view when contacts are fetched
    var onContactsFetched: (() -> Void)?
    var onFetchError: ((Error) -> Void)?
    
    // Function to fetch contacts from the API
    func fetchContacts() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }
        
        // Create a data task to fetch the contacts
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                self?.onFetchError?(error)
                return
            }
            
            guard let data = data else {
                let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])
                self?.onFetchError?(error)
                return
            }
            
            do {
                // Decode the JSON data into an array of Contact objects
                let decodedContacts = try JSONDecoder().decode([Contact].self, from: data)
                self?.contacts = decodedContacts
            } catch {
                self?.onFetchError?(error)
            }
        }
        
        task.resume()
    }
    
    // Function to get the number of contacts
    func numberOfContacts() -> Int {
        return contacts.count
    }
    
    // Function to get a contact at a specific index
    func contact(at index: Int) -> Contact? {
        guard index < contacts.count else { return nil }
        return contacts[index]
    }
}
