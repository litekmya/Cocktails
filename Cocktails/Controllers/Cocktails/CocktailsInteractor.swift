//
//  CocktailsInteractor.swift
//  Cocktails
//
//  Created by Владимир Ли on 05.11.2021.
//

import Foundation
import UIKit

protocol CocktailsInteractorInputProtocol {
    init(presenter: CocktailsInteractorOutputProtocol)
    func provideDrinksData()
}

protocol CocktailsInteractorOutputProtocol: AnyObject {
    func receiveDrinksData(_ coctailsData: [Drink])
}

class CocktailsInteractor: CocktailsInteractorInputProtocol {
    
    unowned let presenter: CocktailsInteractorOutputProtocol
    
    private let networkManager = NetworkManager.shared
    
    required init(presenter: CocktailsInteractorOutputProtocol) {
        self.presenter = presenter
    }
    
    func provideDrinksData() {
        
        networkManager.fetchData(from: URLs.randomTenCocktails.rawValue) { drinks in
            let cocktails = drinks.drinks
            self.presenter.receiveDrinksData(cocktails)
        }
    }
}


