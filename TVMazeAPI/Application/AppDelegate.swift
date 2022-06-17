//
//  AppDelegate.swift
//  TVMazeAPI
//
//  Created by Avinash Kumar on 18/04/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        DataBaseManager().saveContext()
    }
}

