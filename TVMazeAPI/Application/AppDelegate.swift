//
//  AppDelegate.swift
//  TVMazeAPI
//
//  Created by Avinash Kumar on 18/04/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var dataModelName: String?
    
    override init() {
        dataModelName = "DataModel"
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        DataBaseManager().saveContext()
    }
}

