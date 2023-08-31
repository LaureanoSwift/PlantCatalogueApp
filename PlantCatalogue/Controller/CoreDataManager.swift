//  CoreDataManager.swift
//  PlantCatalogue
//  Created by Laureano Velasco on 19/07/2023.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    lazy var persistentContainer : NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PlantModelCoreData")
        
        container.loadPersistentStores(completionHandler: {(storeDescription, error) in
            if let error = error as NSError? {
                fatalError("unsolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    var managedObjectContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
}

extension CoreDataManager {
    
    static func getAllItems() -> [PlantModel2]{
        
        var plantList = [PlantModel2]()
        
        do {
            plantList = try CoreDataManager.shared.managedObjectContext.fetch(PlantModel2.fetchRequest())
        }
        catch {
            print(error.localizedDescription)
        }
        return plantList
    }
    
    func deleteElement(item: PlantModel2, context: NSManagedObjectContext) {
        context.delete(item)
        do{
            try context.save()
        } catch let error as NSError {
            print("no se puedo eliminar", error.localizedDescription)
        }
    }
}
