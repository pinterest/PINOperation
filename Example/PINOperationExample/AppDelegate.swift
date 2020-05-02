//
//  AppDelegate.swift
//  PINOperationExample
//
//  Created by Martin Púčik on 02/05/2020.
//  Copyright © 2020 Pinterest. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let queue = PINOperationQueue(maxConcurrentOperations: 2)
        return true
    }
}
