//
//  ContactsListViewModel.swift
//  Contacts
//
//  Created by Oleksandr Nechet on 01.07.17.
//  Copyright © 2017 Oleksandr Nechet. All rights reserved.
//

import UIKit
import RealmSwift

protocol ContactsListViewModelProtocol
{
    var didUpdatedContactsList: ((_ list: [DTOContact]) -> ())? { get set }
    func fetchContactsAndStartUpdatingChanges()
    func deleteContact(at index: Int)
}

class ContactsListViewModel: ContactsListViewModelProtocol
{
    let provider = ContactsProvider()
    
    //MARK: - ContactsListViewModel protocol conformance
    var didUpdatedContactsList: ((_ list: [DTOContact]) -> ())? {
        didSet {
            provider.contactsDidUpdated = didUpdatedContactsList
        }
    }
    
    func fetchContactsAndStartUpdatingChanges()
    {
        let list = provider.fetch()
        
        DispatchQueue.main.async {
            self.didUpdatedContactsList?(list)
        }
    }
    
    func deleteContact(at index: Int)
    {
        provider.deleteContact(at: index)
    }
}


