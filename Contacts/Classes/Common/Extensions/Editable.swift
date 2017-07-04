//
//  Editable.swift
//  Contacts
//
//  Created by Oleksandr Nechet on 04.07.17.
//  Copyright © 2017 Oleksandr Nechet. All rights reserved.
//

import Foundation

struct EditableItem
{
    let displayTitle: String
    let value: String
    let didChangedValue: (_ value: String) -> ()
}

protocol Editable
{
    var editableItems: [EditableItem] { get }
}
