//
//  Constants.swift
//  SwiftTestRepo
//
//  Created by Apple on 06/08/24.
//

import Foundation

class Constants {
    struct Titles {
        static let contactList = "Contact List"
    }
    
    struct Errors {
        static let fetchError = "Failed to load contacts: "
        static let noDataReceived = "No data received"
    }
    
    struct CellIdentifiers {
        static let contactCell = "contactCell"
    }
    
    struct URLs {
        static let contactsURL = "https://jsonplaceholder.typicode.com/users"
    }
}
