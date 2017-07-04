//
//  ContactsProvider.swift
//  Contacts
//
//  Created by Oleksandr Nechet on 04.07.17.
//  Copyright © 2017 Oleksandr Nechet. All rights reserved.
//

import Foundation
import RealmSwift

class ContactsProvider
{
    var contactsDidUpdated: ((_ contacts: [DTOContact]) -> ())?
    
    private let realm = try! Realm()
    private var notificationToken: NotificationToken? = nil
    private var contactListResult: Results<Contact>!
    
    
    //MARK: - Fetching section
    func fetchContact(by id: String) -> DTOContact
    {
        let contact = realm.object(ofType: Contact.self,
                                   forPrimaryKey: id)!
        let dtoContact = wrap(contact: contact)
        
        return dtoContact
    }
    
    func fetch() -> [DTOContact]
    {
        contactListResult = realm.objects(Contact.self)
        addNotificationObserverToResult()
        
        let dtoContacts = convertResultToArrayOfDTO()
        
        return dtoContacts
    }
    
    //MARK: - Helpers
    private func addNotificationObserverToResult()
    {
        notificationToken = contactListResult.addNotificationBlock {[weak self] (changes: RealmCollectionChange) in
            
            switch changes {
            case .error(let error):
                fatalError("\(error)")
                break
                
            case .initial: fallthrough
            case .update(_, _, _, _):
                guard let contacts = self?.convertResultToArrayOfDTO() else { return }
                self?.contactsDidUpdated?(contacts)
                break
            }
        }
    }
    
    private func convertResultToArrayOfDTO() -> [DTOContact]
    {
        let contactsArray = Array<Contact>(contactListResult)
        let dtoContacts = contactsArray.map{
            self.wrap(contact: $0)
        }
        
        return dtoContacts
    }
    
    private func wrap(contact: Contact) -> DTOContact
    {
        let dtoContact = DTOContact()
        dtoContact.contactID = contact.contactID
        dtoContact.firstName = contact.firstName
        dtoContact.lastName = contact.lastName
        dtoContact.phoneNumber = contact.phoneNumber
        dtoContact.streetAddress1 = contact.streetAddress1
        dtoContact.streetAddress2 = contact.streetAddress2
        dtoContact.city = contact.city
        dtoContact.state = contact.state
        dtoContact.zipCode = contact.zipCode

        return dtoContact
    }
    
    //MARK: - Deletion section
    func deleteContact(at index: Int)
    {
        let contact = contactListResult[index]
        try! realm.write {
            realm.delete(contact)
        }
    }
    
    //MARK: - Saving section
    func save(_ dtoContact: DTOContact)
    {
        var contact = realm.object(ofType: Contact.self,
                                   forPrimaryKey: dtoContact.contactID)
        
        try! realm.write {
            if contact == nil {
                contact = realm.create(Contact.self, value: ["contactID": dtoContact.contactID], update: false)
                realm.add(contact!)
            }
            contact!.firstName = dtoContact.firstName
            contact!.lastName = dtoContact.lastName
            contact!.phoneNumber = dtoContact.phoneNumber
            contact!.streetAddress1 = dtoContact.streetAddress1
            contact!.streetAddress2 = dtoContact.streetAddress2
            contact!.city = dtoContact.city
            contact!.state = dtoContact.state
            contact!.zipCode = dtoContact.zipCode
            
        }
    }
}
