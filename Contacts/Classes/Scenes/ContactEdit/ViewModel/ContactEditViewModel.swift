//
//  ContactEditViewModel.swift
//  Contacts
//
//  Created by Oleksandr Nechet on 04.07.17.
//  Copyright © 2017 Oleksandr Nechet. All rights reserved.
//

import Foundation

class ContactEditViewModel
{
    var contactId: String?
    private let provider = ContactsProvider()
    private var contact: DTOContact!
    
    var displayItems: [EditableItem] {
        if let contactId = contactId {
            contact = provider.fetchContact(by: contactId)
        }
        else {
            contact = DTOContact()
        }
        
        return contact.editableItems
    }
    
    func saveChanges()
    {
        provider.save(contact)
    }
}
