//
//  CocktailDetailsInteractor.swift
//  Cocktails
//
//  Created by Владимир Ли on 22.11.2021.
//

import Foundation

protocol CocktailDetailsInteractorInputProtocol: AnyObject {
    init(presenter: CocktailDetailsInteractorOutputProtocol)
}

protocol CocktailDetailsInteractorOutputProtocol {

}

class CocktailDetailsInteractor {
    
    var presenter: CocktailDetailsInteractorOutputProtocol
    
    required init(presenter: CocktailDetailsInteractorOutputProtocol) {
        self.presenter = presenter
    }
    
}

extension CocktailDetailsInteractor: CocktailDetailsInteractorInputProtocol {
    
}
