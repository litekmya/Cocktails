//
//  Cocktail+CoreDataProperties.swift
//  Cocktails
//
//  Created by Владимир Ли on 19.04.2022.
//
//

import Foundation
import CoreData


extension Cocktail {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Cocktail> {
        return NSFetchRequest<Cocktail>(entityName: "Cocktail")
    }

    @NSManaged public var title: String?
    @NSManaged public var ingredients: String?
    @NSManaged public var measures: String?
    @NSManaged public var instruction: String?
    @NSManaged public var alcoholic: String?
    @NSManaged public var glass: String?
    @NSManaged public var imageString: String?

}

extension Cocktail : Identifiable {

}
