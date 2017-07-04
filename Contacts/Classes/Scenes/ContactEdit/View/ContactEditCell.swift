//
//  ContactEditCell.swift
//  Contacts
//
//  Created by Oleksandr Nechet on 04.07.17.
//  Copyright © 2017 Oleksandr Nechet. All rights reserved.
//

import UIKit

class ContactEditCell: UITableViewCell
{
    @IBOutlet private var labelTitle: UILabel!
    @IBOutlet private var textFieldValue: UITextField!
    var displayItem: EditableItem! {
        didSet { setup() }
    }
    
    //MARK: - Object lifecycle
    private func setup()
    {
        labelTitle.text = displayItem.displayTitle
        textFieldValue.text = displayItem.value
    }
    
    //MARK: - IBActions
    @IBAction func valueTextDidChanged(_ sender: UITextField)
    {
        displayItem.didChangedValue(sender.text ?? "")
    }
}
