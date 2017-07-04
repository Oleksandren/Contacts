//
//  DTOContact.swift
//  Contacts
//
//  Created by Oleksandr Nechet on 03.07.17.
//  Copyright © 2017 Oleksandr Nechet. All rights reserved.
//

import Foundation

class DTOContact
{
    var contactID: String = UUID().uuidString
    var firstName: String = ""
    var lastName: String = ""
    var phoneNumber: String = ""
    var streetAddress1: String = ""
    var streetAddress2: String = ""
    var city: String = ""
    var state: String = ""
    var zipCode: String = ""
    
    //MARK: - Convience methods
    var fullName: String {
        return "\(firstName)  \(lastName)"
    }
}

//MARK: - Editable

extension DTOContact: Editable
{
    var editableItems: [EditableItem] {
        return [EditableItem(displayTitle: Constants.ContactTitles.firstName,
                             value: firstName,
                             didChangedValue: { newValue in
                                self.firstName = newValue
                }),
                EditableItem(displayTitle: Constants.ContactTitles.lastName,
                            value: lastName,
                            didChangedValue: { newValue in
                                self.lastName = newValue
                }),
                EditableItem(displayTitle: Constants.ContactTitles.phoneNumber,
                            value: phoneNumber,
                            didChangedValue: { newValue in
                                self.phoneNumber = newValue
                }),
                EditableItem(displayTitle: Constants.ContactTitles.streetAddress1,
                            value: streetAddress1,
                            didChangedValue: { newValue in
                                self.streetAddress1 = newValue
                }),
                EditableItem(displayTitle: Constants.ContactTitles.streetAddress2,
                            value: streetAddress2,
                            didChangedValue: { newValue in
                                self.streetAddress2 = newValue
                }),
                EditableItem(displayTitle: Constants.ContactTitles.city,
                            value: city,
                            didChangedValue: { newValue in
                                self.city = newValue
                }),
                EditableItem(displayTitle: Constants.ContactTitles.state,
                            value: state,
                            didChangedValue: { newValue in
                                self.state = newValue
                }),
                EditableItem(displayTitle: Constants.ContactTitles.zipCode,
                            value: zipCode,
                            didChangedValue: { newValue in
                                self.zipCode = newValue
                })]
    }
}
