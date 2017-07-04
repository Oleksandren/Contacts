//
//  ContactEditViewController.swift
//  Contacts
//
//  Created by Oleksandr Nechet on 01.07.17.
//  Copyright © 2017 Oleksandr Nechet. All rights reserved.
//

import UIKit

class ContactEditViewController: UIViewController
{
    @IBOutlet private weak var tableViewContent: UITableView!
    let viewModel = ContactEditViewModel()
    fileprivate var displayItems: [EditableItem] = []
    
    //MARK: - ViewController lifecycle
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        reloadData()
    }
    
    //MARK: - Helpers
    private func reloadData()
    {
        displayItems = viewModel.displayItems
        tableViewContent.reloadData()
    }
    
    //MARK: - IBActions
    @IBAction func onClose()
    {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onSave()
    {
        viewModel.saveChanges()
        onClose()
    }
}

//MARK: - UITableViewDataSource
extension ContactEditViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int
    {
        return displayItems.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ContactEditCell.self),
                                                 for: indexPath) as! ContactEditCell
        let displayItem = displayItems[indexPath.row]
        cell.displayItem = displayItem
        
        return cell
    }
}
