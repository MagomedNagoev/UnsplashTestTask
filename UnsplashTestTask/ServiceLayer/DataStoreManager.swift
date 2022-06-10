//
//  DataStoreManager.swift
//  UnsplashTestTask
//
//  Created by Нагоев Магомед on 08.06.2022.
//

import Foundation
import CoreData


open class DataStoreManager {
    public static let modelName = "UnsplashTestTask"
    public static let model: NSManagedObjectModel = {
        let modelURL = Bundle.main.url(forResource: modelName, withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    public init() {
        
    }

    public lazy var mainContext: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()
    
    lazy var fetchedResultsController:NSFetchedResultsController<FavoritePhoto> = {
        let fetchRequest: NSFetchRequest<FavoritePhoto> = FavoritePhoto.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        let resultController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                                managedObjectContext: mainContext,
                                                                sectionNameKeyPath: nil,
                                                                cacheName: nil)
        return resultController
    }()

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: DataStoreManager.modelName, managedObjectModel: DataStoreManager.model)
        container.loadPersistentStores { _, error in
          if let error = error as NSError? {
            fatalError("Unresolved error \(error), \(error.userInfo)")
          }
        }
        return container
      }()
    
    
    // MARK: - Core Data Saving support
    public func newDerivedContext() -> NSManagedObjectContext {
        let context = persistentContainer.newBackgroundContext()
        return context
    }

    public func saveContext(_ context: NSManagedObjectContext) {
      if context != mainContext {
        saveDerivedContext(context)
        return
      }

      context.perform {
        do {
          try context.save()
        } catch let error as NSError {
          fatalError("Unresolved error \(error), \(error.userInfo)")
        }
      }
    }

    public func saveDerivedContext(_ context: NSManagedObjectContext) {
      context.perform {
        do {
          try context.save()
        } catch let error as NSError {
          fatalError("Unresolved error \(error), \(error.userInfo)")
        }

        self.saveContext(self.mainContext)
      }
    }
}

