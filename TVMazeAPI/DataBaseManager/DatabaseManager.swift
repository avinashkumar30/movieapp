//
//  DatabaseManager.swift
//  TVMazeAPI
//
//  Created by Avinash Kumar on 10/06/22.
//

import Foundation
import CoreData
import UIKit

class DataBaseManager {
    var shows = [Show]()
    
    // MARK: - Core Data stack

    var persistentContainer = NSPersistentContainer(name : "DataModel")
    
    let context: NSManagedObjectContext
    
    init() {
        persistentContainer.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        self.context = persistentContainer.viewContext
    }
    
    // MARK: - Core Data Saving support

    func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK :- Core Data Methods
    
    
    func saveItems() {
        do {
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
    }
    
    func loadItems(completionHandler: @escaping ([Show]) -> ()) {
        let request: NSFetchRequest<Show> = Show.fetchRequest()
        do {
            shows = try context.fetch(request)
            completionHandler(shows)
        } catch {
            print("Error fetching data from context \(error)")
        }
    }
    
}
