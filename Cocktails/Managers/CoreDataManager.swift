//
//  CoreDataManager.swift
//  Cocktails
//
//  Created by Владимир Ли on 19.04.2022.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    private var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Cocktails")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    private init() {}
    
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
    
    func saveFavorite(from cocktailData: CocktailData, ingredients: String?, completion: (Cocktail) -> Void){
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "Cocktail", in: context) else { return }
        guard let cocktail = NSManagedObject(entity: entityDescription, insertInto: context) as? Cocktail else { return }
        
        cocktail.title = cocktailData.title
        cocktail.imageString = cocktailData.imageString
        cocktail.alcoholic = cocktailData.alcoholic
        cocktail.glass = cocktailData.glass
        cocktail.ingredients = ingredients
        cocktail.instruction = cocktailData.instruction
        
        completion(cocktail)
        saveContext()
    }
    
    func fetchData() -> [Cocktail] {
        var cocktails: [Cocktail] = []
        let fetchRequest: NSFetchRequest<Cocktail> = Cocktail.fetchRequest()
        
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            cocktails = try persistentContainer.viewContext.fetch(fetchRequest)
            
        } catch let error {
            print(error.localizedDescription)
        }
        
        return cocktails
    }
    
    func deleteFavorite(cocktail: Cocktail) {
        context.delete(cocktail)
        saveContext()
    }
}
