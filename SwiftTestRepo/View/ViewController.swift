//
//  ViewController.swift
//  SwiftTestRepo
//
//  Created by Apple on 06/08/24.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    
    // ViewModel instance to manage contact data
    var viewModel = ContactViewModel()
    
    // UITableView to display the list of contacts
    var tableView = UITableView()
    var activityIndicator = UIActivityIndicatorView(style: .large)
    var errorLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the title for the navigation bar
        self.title = "Contact List"
        
        setupTableView()
        setupActivityIndicator()
        setupErrorLabel()
        setupViewModel()
        
        // Fetch contacts from the ViewModel
        viewModel.fetchContacts()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        // Register the custom cell class
        tableView.register(ContactTableViewCell.self, forCellReuseIdentifier: "contactCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableFooterView = UIView() // Removes empty cell separators
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func setupActivityIndicator() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func setupErrorLabel() {
        errorLabel.textAlignment = .center
        errorLabel.numberOfLines = 0
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.isHidden = true
        
        view.addSubview(errorLabel)
        
        NSLayoutConstraint.activate([
            errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            errorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            errorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    func setupViewModel() {
        viewModel.onContactsFetched = { [weak self] in
            self?.activityIndicator.stopAnimating()
            self?.tableView.reloadData()
            self?.errorLabel.isHidden = true
        }
        
        viewModel.onFetchError = { [weak self] error in
            self?.activityIndicator.stopAnimating()
            self?.errorLabel.text = "Failed to load contacts: \(error.localizedDescription)"
            self?.errorLabel.isHidden = false
        }
    }
    
    // UITableViewDataSource method to get the number of rows in the section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfContacts()
    }
    
    // UITableViewDataSource method to configure the cell for a row at a specific indexPath
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as! ContactTableViewCell
        
        if let contact = viewModel.contact(at: indexPath.row) {
            cell.configure(with: contact)
        }
        
        return cell
    }
}
