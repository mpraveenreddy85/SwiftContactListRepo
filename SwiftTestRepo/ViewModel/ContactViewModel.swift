//
//  ContactViewModel.swift
//  SwiftTestRepo
//
//  Created by Apple on 06/08/24.
//

import Foundation

class ContactViewModel {
    private var contacts: [Contact] = []
    var onContactsFetched: (() -> Void)?
    
    func fetchContacts() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decodedContacts = try JSONDecoder().decode([Contact].self, from: data)
                    self.contacts = decodedContacts
                    DispatchQueue.main.async {
                        self.onContactsFetched?()
                    }
                } catch {
                    print("Error decoding data: \(error)")
                }
            }
        }
        
        task.resume()
    }
    
    func numberOfContacts() -> Int {
        return contacts.count
    }
    
    func contact(at index: Int) -> Contact? {
        guard index < contacts.count else { return nil }
        return contacts[index]
    }
}
