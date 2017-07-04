//
//  ContactsListTableViewController.swift
//  Contacts
//
//  Created by Oleksandr Nechet on 30.06.17.
//  Copyright © 2017 Oleksandr Nechet. All rights reserved.
//

import UIKit

class ContactsListTableViewController: UITableViewController
{
    private enum Segue: String
    {
        case toContactDetails = "segueToContactDetailsTableViewController"
    }
    
    private var displayedItems: [DTOContact] = []
    private let viewModel = ContactsListViewModel()
    
    //MARK: - ViewController lifecycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setup()
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        super.prepare(for: segue, sender: sender)
        guard let identifier = segue.identifier else { return }
        switch identifier {
        case Segue.toContactDetails.rawValue:
            guard let selectedIndex = tableView.indexPathForSelectedRow?.row else {
                fatalError()
            }
            let contactID = displayedItems[selectedIndex].contactID
            (segue.destination as! ContactDetailsTableViewController).viewModel.contactId = contactID
            
        default: break
        }
    }
    
    //MARK: - UITableViewDataSource
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int
    {
        return displayedItems.count
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self),
                                                 for: indexPath)
        let contact = displayedItems[indexPath.row]
        cell.textLabel?.text = contact.fullName
        cell.detailTextLabel?.text = contact.phoneNumber
        
        return cell
    }
    
    //MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView,
                   canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCellEditingStyle,
                            forRowAt indexPath: IndexPath)
    {
        if (editingStyle == .delete) {
            viewModel.deleteContact(at: indexPath.row)
        }
    }
    
    //MARK: - Configurators
    private func setup()
    {
        viewModel.didUpdatedContactsList = { list in
            self.displayedItems = list
            self.tableView.reloadData()
        }
        viewModel.fetchContactsAndStartUpdatingChanges()
    }
}
