//
//  CoreDataStorage.swift
//  CodawayGen
//
//  Created by Youssef Marouane
//  Copyright © 2021 Youssef Marouane.
//

import Foundation
import CoreData

enum CoreDataStorageError: Error {
    case readError(Error)
    case saveError(Error)
    case deleteError(Error)
}

final class CoreDataStorageService {

    static let shared = CoreDataStorageService()
    let identifier: String  = "com.mmy.OpenWeatherCore"
    let model: String       = "OpenWeatherCore"
    
    // MARK: - Core Data stack
    private lazy var persistentContainer: NSPersistentContainer = {
        
        let openWeatherBundle = Bundle(identifier: self.identifier)
        let modelURL = openWeatherBundle!.url(forResource: self.model, withExtension: "momd")!
        let managedObjectModel =  NSManagedObjectModel(contentsOf: modelURL)
        let container = NSPersistentContainer(name: self.model, managedObjectModel: managedObjectModel!)
        container.loadPersistentStores { (storeDescription, error) in
            if let err = error{
                fatalError("❌ Loading of store failed:\(err)")
            }
        }
        
        return container
    }()

    func performBackgroundTask(_ block: @escaping (NSManagedObjectContext) -> Void) {
        persistentContainer.performBackgroundTask(block)
    }
}
