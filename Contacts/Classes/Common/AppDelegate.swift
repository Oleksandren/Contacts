//
//  AppDelegate.swift
//  Contacts
//
//  Created by Oleksandr Nechet on 30.06.17.
//  Copyright © 2017 Oleksandr Nechet. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{
    var window: UIWindow?

    //MARK: - UIApplicationDelegate
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool
    {
        DefaultContactsImporter.importIfNeeded()
        
        return true
    }
}
