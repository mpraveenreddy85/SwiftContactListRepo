//
//  ContactTableViewCell.swift
//  SwiftTestRepo
//
//  Created by Apple on 06/08/24.
//

import UIKit

class ContactTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCell()
    }
    
    private func setupCell() {
        // Additional setup if needed
        textLabel?.textColor = .black
        detailTextLabel?.textColor = .gray
    }
    
    func configure(with contact: Contact) {
        textLabel?.text = contact.name
        detailTextLabel?.text = contact.email
    }
}
