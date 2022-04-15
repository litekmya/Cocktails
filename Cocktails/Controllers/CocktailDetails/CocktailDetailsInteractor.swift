//
//  CocktailDetailsInteractor.swift
//  Cocktails
//
//  Created by Владимир Ли on 22.11.2021.
//

import Foundation

protocol CocktailDetailsInteractorInputProtocol: AnyObject {
    init(presenter: CocktailDetailsInteractorOutputProtocol)
    func provideData()
}

protocol CocktailDetailsInteractorOutputProtocol {
    func recieveData()
}

class CocktailDetailsInteractor: CocktailDetailsInteractorInputProtocol {
    
    var presenter: CocktailDetailsInteractorOutputProtocol
    
    required init(presenter: CocktailDetailsInteractorOutputProtocol) {
        self.presenter = presenter
    }
    
    func provideData() {
        presenter.recieveData()
    }
    
}
