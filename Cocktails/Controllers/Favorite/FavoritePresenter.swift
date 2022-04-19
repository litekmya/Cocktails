//
//  FavoritePresenter.swift
//  Cocktails
//
//  Created by Владимир Ли on 19.04.2022.
//

import Foundation

class FavoritePresenter {
    
    unowned var view: FavoriteViewInputProtocol
    var interactor: FavoriteInteractorInputProtocol!
    
    var favoriteCocktails: [Cocktail] = []
    
    required init(view: FavoriteViewInputProtocol) {
        self.view = view
    }
}

extension FavoritePresenter: FavoriteViewOutputProtocol {
    
    func provideData() {
        interactor.provideData()
    }
    
    func getFavoriteCocktails() -> [Cocktail] {
        print(favoriteCocktails.count)
        return favoriteCocktails
    }
}

extension FavoritePresenter: FavoriteInteractorOutputProtocol {
    
    func customizeView() {
        view.customizeTableView()
    }
    
    func recieveData(_ favoriteCocktails: [Cocktail]) {
        self.favoriteCocktails = favoriteCocktails
        self.view.reloadData()
    }
}
