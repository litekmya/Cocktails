//
//  CocktailsData.swift
//  Cocktails
//
//  Created by Владимир Ли on 07.11.2021.
//

import UIKit

// Для передачи данных можно создать дополнительную модель данных, для того, чтобы было проще передовать данные в другие классы
struct CocktailsData {
    let title: String
    var image: UIImage?
    let ingredients: [String]
    let instruction: String
}
