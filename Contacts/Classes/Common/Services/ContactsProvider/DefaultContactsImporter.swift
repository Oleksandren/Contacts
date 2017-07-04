//
//  DefaultContactsImporter.swift
//  Contacts
//
//  Created by Oleksandr Nechet on 01.07.17.
//  Copyright © 2017 Oleksandr Nechet. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift


class DefaultContactsImporter
{
    private struct Keys {
        static internal let alreadyImportedDefaultContacts = "alreadyImportedDefaultContacts"
    }
    private static var isAlreadyImportedDefaultContacts: Bool {
        get { return UserDefaults.standard.bool(forKey: Keys.alreadyImportedDefaultContacts) }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.alreadyImportedDefaultContacts)
            UserDefaults.standard.synchronize()
        }
    }
    private static let defaultContactsFileName = "DefaultContacts.txt"
    
    //MARK: - Public
    static func importIfNeeded()
    {
        DispatchQueue.global().async {
            if !isAlreadyImportedDefaultContacts {
                importDefaultContacts()
                isAlreadyImportedDefaultContacts = true
            }
        }
    }
    
    //MARK: - Helpers
    private static func importDefaultContacts()
    {
        let realm = try! Realm()
        try! realm.write {
            realm.add(contacts())
        }
    }
    
    private static func contacts() -> [Contact]
    {
        guard let path = Bundle.main.path(forResource: defaultContactsFileName,
                                          ofType: "") else
        {
            fatalError()
        }
        
        let contactsJSONString = try! String(contentsOfFile: path)
        
        guard let contacts = Mapper<Contact>().mapArray(JSONString: contactsJSONString) else
        {
            fatalError()
        }
        
        return contacts
    }
}
