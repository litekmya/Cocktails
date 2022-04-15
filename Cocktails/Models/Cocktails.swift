//
//  Cocktails.swift
//  Cocktails
//
//  Created by Владимир Ли on 08.11.2021.
//

import Foundation

struct Cocktails: Codable {
    let drinks: [Drink]
}

struct Drink: Codable {
    let idDrink: String?
    let strDrink: String?
    let strTags: String?
    let strAlcoholic: String?
    let strInstructions: String?
    let strDrinkThumb: String?
    let strIngredient1: String?
    let strIngredient2: String?
    let strIngredient3: String?
    let strIngredient4: String?
    let strIngredient5: String?
    let strIngredient6: String?
    let strIngredient7: String?
    let strIngredient8: String?
    let strIngredient9: String?
    let strIngredient10: String?
    let strIngredient11: String?
    let strIngredient12: String?
    let strIngredient13: String?
    let strIngredient14: String?
    let strIngredient15: String?
    let strMeasure1: String?
    let strMeasure2: String?
    let strMeasure3: String?
    let strMeasure4: String?
    let strMeasure5: String?
}
