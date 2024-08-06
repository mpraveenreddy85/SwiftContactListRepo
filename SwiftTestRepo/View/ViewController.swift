//
//  ViewController.swift
//  SwiftTestRepo
//
//  Created by Apple on 06/08/24.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource  {

    private var viewModel = ContactViewModel()
        private var tableView = UITableView()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            title = "Contacts"
            tableView.dataSource = self
            view.addSubview(tableView)
            tableView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                tableView.topAnchor.constraint(equalTo: view.topAnchor),
                tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
            
            viewModel.onContactsFetched = { [weak self] in
                self?.tableView.reloadData()
            }
            
            viewModel.fetchContacts()
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return viewModel.numberOfContacts()
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
            if let contact = viewModel.contact(at: indexPath.row) {
                cell.textLabel?.text = contact.name
                cell.detailTextLabel?.text = contact.email
            }
            return cell
        }
    }
