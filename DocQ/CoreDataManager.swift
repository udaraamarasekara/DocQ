//
//  CoreDataManager.swift
//  DocQ
//
//  Created by udara prabath on 2025-03-31.
//

import CoreData

class CoreDataManager {
    static let shared = CoreDataManager() // Singleton

    let persistentContainer: NSPersistentContainer

    private init() {
        persistentContainer = NSPersistentContainer(name: "YourModelName") // Replace with your .xcdatamodeld name
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }

    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    func saveContext() {
        do {
            try context.save()
        } catch {
            print("Failed to save Core Data: \(error.localizedDescription)")
        }
    }
}
