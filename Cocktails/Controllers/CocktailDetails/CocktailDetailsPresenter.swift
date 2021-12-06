//
//  CocktailDetailsPresenter.swift
//  Cocktails
//
//  Created by Владимир Ли on 22.11.2021.
//

import Foundation

class CocktailDetailsPresenter {
    
    unowned let view: CocktailDetailsViewInputProtocol
    var interactor: CocktailDetailsInteractorInputProtocol!
    
    required init(view: CocktailDetailsViewInputProtocol) {
        self.view = view
    }
}

extension CocktailDetailsPresenter: CocktailDetailsViewOutputProtocol {
    
}

extension CocktailDetailsPresenter: CocktailDetailsInteractorOutputProtocol {
    
}
