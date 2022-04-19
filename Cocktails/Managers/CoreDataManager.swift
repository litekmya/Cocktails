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
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Cocktails")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private init() {}
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                print("Cocktail is saved")
            } catch {

                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func saveFavorite(from cocktailData: CocktailData, ingredients: String?) {
        let context = persistentContainer.viewContext
        
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "Cocktail", in: context) else { return }
        guard let cocktail = NSManagedObject(entity: entityDescription, insertInto: context) as? Cocktail else { return }
        
        cocktail.title = cocktailData.title
        cocktail.imageString = cocktailData.imageString
        cocktail.alcoholic = cocktailData.alcoholic
        cocktail.glass = cocktailData.glass
        cocktail.ingredients = ingredients
        cocktail.instruction = cocktailData.instruction
        
        saveContext()
    }
    
    func fetchData() -> [Cocktail] {
        var cocktails: [Cocktail] = []
        let fetchRequest: NSFetchRequest<Cocktail> = Cocktail.fetchRequest()
        
        do {
            cocktails = try persistentContainer.viewContext.fetch(fetchRequest)
            print(cocktails.count)
            
        } catch let error {
            print(error.localizedDescription)
        }
        
        return cocktails
    }
}
