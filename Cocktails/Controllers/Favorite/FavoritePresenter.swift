//
//  FavoritePresenter.swift
//  Cocktails
//
//  Created by Владимир Ли on 19.04.2022.
//

import UIKit

class FavoritePresenter {
    
    unowned var view: FavoriteViewInputProtocol
    var interactor: FavoriteInteractorInputProtocol!
    var router: FavoriteRouterProtocol!
    
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
        favoriteCocktails
    }
    
    func showCocktailDetails(at indexPath: Int, and image: UIImage) {
        let favoriteCocktail = favoriteCocktails[indexPath]
        router.openCocktailDetailsViewController(with: favoriteCocktail, and: image)
    }
}

extension FavoritePresenter: FavoriteInteractorOutputProtocol {
    
    func customizeView() {
        view.customizeTableView()
    }
    
    func recieveData(_ favoriteCocktails: [Cocktail]) {
        self.favoriteCocktails = favoriteCocktails
    }
}
