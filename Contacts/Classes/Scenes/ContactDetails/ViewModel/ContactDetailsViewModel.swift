//
//  ContactDetailsViewModel.swift
//  Contacts
//
//  Created by Oleksandr Nechet on 04.07.17.
//  Copyright © 2017 Oleksandr Nechet. All rights reserved.
//

import Foundation

class ContactDetailsViewModel
{
    var contactId: String!
    private let provider = ContactsProvider()
    
    var displayItems: [EditableItem] {
        let contact = provider.fetchContact(by: contactId)
        
        return contact.editableItems
    }
}
