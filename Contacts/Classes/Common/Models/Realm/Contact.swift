//
//  Contact.swift
//  Contacts
//
//  Created by Oleksandr Nechet on 03.07.17.
//  Copyright © 2017 Oleksandr Nechet. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class Contact: Object, Mappable
{
    dynamic var contactID: String = ""
    dynamic var firstName: String = ""
    dynamic var lastName: String = ""
    dynamic var phoneNumber: String = ""
    dynamic var streetAddress1: String = ""
    dynamic var streetAddress2: String = ""
    dynamic var city: String = ""
    dynamic var state: String = ""
    dynamic var zipCode: String = ""
    
    override static func primaryKey() -> String?
    {
        return "contactID"
    }
    
    //MARK: - Mappable
    
    private struct Keys {
        static let contactID = "contactID"
        static let firstName = "firstName"
        static let lastName = "lastName"
        static let phoneNumber = "phoneNumber"
        static let streetAddress1 = "streetAddress1"
        static let streetAddress2 = "streetAddress2"
        static let city = "city"
        static let state = "state"
        static let zipCode = "zipCode"
    }
    
    required convenience init?(map: Map)
    {
        self.init()
    }
    func mapping(map: Map) {
        contactID <- map[Keys.contactID]
        firstName <- map[Keys.firstName]
        lastName <- map[Keys.lastName]
        phoneNumber <- map[Keys.phoneNumber]
        streetAddress1 <- map[Keys.streetAddress1]
        streetAddress2 <- map[Keys.streetAddress2]
        city <- map[Keys.city]
        state <- map[Keys.state]
        zipCode <- map[Keys.zipCode]
    }
}
