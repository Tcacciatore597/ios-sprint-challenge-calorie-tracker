//
//  CoreDataStack.swift
//  CalorieTracker
//
//  Created by Thomas Cacciatore on 7/5/19.
//  Copyright © 2019 Thomas Cacciatore. All rights reserved.
//

import Foundation
import CoreData
import SwiftChart

class CoreDataStack {
    
    static let shared = CoreDataStack()
    
    func save(context: NSManagedObjectContext = CoreDataStack.shared.mainContext)
        throws {
            
            var error: Error?
            
            context.performAndWait {
                do {
                    try context.save()
                } catch let saveError {
                    error = saveError
                }
            }
            if let error = error { throw error }
    }
    
    
    lazy var container: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "CalorieTracker")
        container.loadPersistentStores { (_, error) in
            if let error = error {
                fatalError("Failed to load persistent stores \(error)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
        
        return container
        
    }()
    
    var mainContext: NSManagedObjectContext {
        return container.viewContext
    }
}
