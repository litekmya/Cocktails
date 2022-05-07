//
//  ListAllCocktailsModel.swift
//  Cocktails
//
//  Created by Владимир Ли on 26.04.2022.
//

import Foundation

struct ListAllCocktailsModel {
    var sectionName: String
    var cocktails: Cocktails
    var expanded: Bool
    
    static var sections: [ListAllCocktailsModel] = []
}

extension ListAllCocktailsModel {
    
    static func getDataForSections() -> [ListAllCocktailsModel] {
        let alphabet = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j",
                        "k", "l", "m", "n", "o", "p", "q", "r", "s", "t",
                        "u", "v","w", "x", "y", "z"]
        
        DispatchQueue.main.async {
            for index in 0..<alphabet.count {
                NetworkManager.shared.fetchData(from: URLs.allCocktails.rawValue + alphabet[index]) { cocktails in
                    let section = ListAllCocktailsModel(sectionName: alphabet[index], cocktails: cocktails, expanded: false)
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        sections.append(section)
                    }
                }
            }
        }
        
        return sections
    }
}
