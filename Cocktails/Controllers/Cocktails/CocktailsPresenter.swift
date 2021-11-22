//
//  CocktailsPresenter.swift
//  Cocktails
//
//  Created by Владимир Ли on 05.11.2021.
//

import Foundation
import UIKit

class CocktailsPresenter {
    
    unowned var view: CocktailsViewInputProtocol
    var interactor: CocktailsInteractorInputProtocol!
    
    private var coctails: [Drink]!
    
    required init(view: CocktailsViewInputProtocol) {
        self.view = view
    }
}

extension CocktailsPresenter: CocktailsViewOutputProtocol {
    
    func requestData() {
        interactor.provideDrinksData()
    }
}

extension CocktailsPresenter: CocktailsInteractorOutputProtocol {
    func receiveDrinksData(_ coctailsData: [Drink]) {
        view.cocktails = coctailsData
        view.setCocktails(coctailsData)
    }
}
