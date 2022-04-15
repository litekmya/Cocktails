//
//  CocktailsInteractor.swift
//  Cocktails
//
//  Created by Владимир Ли on 05.11.2021.
//

import Foundation
import UIKit

//MARK: - Protocols
protocol CocktailsInteractorInputProtocol {
    init(presenter: CocktailsInteractorOutputProtocol)
    func provideDrinksData()
}

protocol CocktailsInteractorOutputProtocol: AnyObject {
    func customizeView()
    func receiveDrinksData(_ coctailsData: [Drink])
}

//MARK: - Class
class CocktailsInteractor: CocktailsInteractorInputProtocol {
    
    unowned let presenter: CocktailsInteractorOutputProtocol
    
    private let networkManager = NetworkManager.shared
    private var cocktails: [Drink]!
    
    required init(presenter: CocktailsInteractorOutputProtocol) {
        self.presenter = presenter
    }
    
    func provideDrinksData() {
        networkManager.fetchData(from: URLs.randomTenCocktails.rawValue) { drinks in
            self.cocktails = drinks.drinks
            self.presenter.customizeView()
            self.presenter.receiveDrinksData(self.cocktails)
        }
    }
}


