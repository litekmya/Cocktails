//
//  CocktailData.swift
//  Cocktails
//
//  Created by Владимир Ли on 07.11.2021.
//

import UIKit

// Для передачи данных можно создать дополнительную модель данных, для того, чтобы было проще передовать данные в другие классы
struct CocktailData {
    var title = ""
    var ingredients: [String] = []
    var measures: [String] = []
    var instruction = ""
    var alcoholic = ""
    var glass = ""
    var imageString = ""
        
    init() {}
    init(cocktail: Drink) {
        self.title = cocktail.strDrink ?? ""
        self.ingredients = [
            cocktail.strIngredient1 ?? "",
            cocktail.strIngredient2 ?? "",
            cocktail.strIngredient3 ?? "",
            cocktail.strIngredient4 ?? "",
            cocktail.strIngredient5 ?? "",
            cocktail.strIngredient6 ?? "",
            cocktail.strIngredient7 ?? "",
            cocktail.strIngredient8 ?? "",
            cocktail.strIngredient9 ?? "",
            cocktail.strIngredient10 ?? "",
            cocktail.strIngredient11 ?? "",
            cocktail.strIngredient12 ?? "",
            cocktail.strIngredient13 ?? "",
            cocktail.strIngredient14 ?? "",
            cocktail.strIngredient15 ?? ""
        ]
        self.measures = [
            cocktail.strMeasure1 ?? "",
            cocktail.strMeasure2 ?? "",
            cocktail.strMeasure3 ?? "",
            cocktail.strMeasure4 ?? "",
            cocktail.strMeasure5 ?? "",
            cocktail.strMeasure6 ?? "",
            cocktail.strMeasure7 ?? "",
            cocktail.strMeasure8 ?? "",
            cocktail.strMeasure9 ?? "",
            cocktail.strMeasure10 ?? "",
            cocktail.strMeasure11 ?? "",
            cocktail.strMeasure12 ?? "",
            cocktail.strMeasure13 ?? "",
            cocktail.strMeasure14 ?? "",
            cocktail.strMeasure15 ?? ""
        ]
        self.instruction = cocktail.strInstructions ?? ""
        self.alcoholic = cocktail.strAlcoholic ?? ""
        self.glass = cocktail.strGlass ?? ""
        self.imageString = cocktail.strDrinkThumb ?? ""
    }
    
    init(cocktail: Cocktail) {
        self.title = cocktail.title ?? ""
        self.ingredients = [cocktail.ingredients ?? ""]
        self.instruction = cocktail.instruction ?? ""
        self.alcoholic = cocktail.alcoholic ?? ""
        self.glass = cocktail.glass ?? ""
        self.imageString = cocktail.imageString ?? ""
        
    }
}
