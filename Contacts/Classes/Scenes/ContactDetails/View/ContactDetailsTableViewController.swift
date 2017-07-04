//
//  ContactDetailsTableViewController.swift
//  Contacts
//
//  Created by Oleksandr Nechet on 03.07.17.
//  Copyright © 2017 Oleksandr Nechet. All rights reserved.
//

import UIKit

class ContactDetailsTableViewController: UITableViewController
{
    private enum Segue: String
    {
        case toContactEdit = "segueToContactEditViewController"
    }
    var viewModel = ContactDetailsViewModel()
    var displayItems: [EditableItem] = []
    
    //MARK: - ViewController lifecycle
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        reloadData()
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        super.prepare(for: segue, sender: sender)
        guard let identifier = segue.identifier else { return }
        switch identifier {
        case Segue.toContactEdit.rawValue:
            (segue.destination as! ContactEditViewController).viewModel.contactId = viewModel.contactId
            
        default: break
        }
    }
    
    //MARK: - UITableViewDataSource
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int
    {
        return displayItems.count
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self),
                                                 for: indexPath)
        let displayItem = displayItems[indexPath.row]
        cell.textLabel?.text = displayItem.displayTitle
        cell.detailTextLabel?.text = displayItem.value
        
        return cell
    }
    
    //MARK: - Helpers
    private func reloadData()
    {
        displayItems = viewModel.displayItems
        tableView.reloadData()   
    }
}
