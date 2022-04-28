//
//  ListAllCocktailsModel.swift
//  Cocktails
//
//  Created by Владимир Ли on 26.04.2022.
//

import Foundation

struct ListAllCocktailsModel {
    var sectionName: String
    var cocktails: [String?]
    var expanded: Bool
}

extension ListAllCocktailsModel {
    
    static func getNameForSections() -> [ListAllCocktailsModel] {
        let alphabet = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j",
                        "k", "l", "m", "n", "o", "p", "q", "r", "s", "t",
                        "u", "v","w", "x", "y", "z"]
        var sectionsName: [ListAllCocktailsModel] = []
        
        for number in 0..<alphabet.count {
            let newSectionName = ListAllCocktailsModel(sectionName: alphabet[number], cocktails: ["1" ,"2"  , "3"], expanded: false)
            print(newSectionName)
            sectionsName.append(newSectionName)
        }
        print(sectionsName)
        return sectionsName
    }
}
