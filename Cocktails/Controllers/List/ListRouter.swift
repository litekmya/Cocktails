//
//  ListRouter.swift
//  Cocktails
//
//  Created by Владимир Ли on 26.04.2022.
//

import Foundation

protocol ListRouterProtocol {
    init(view: ListViewController)
    
    func openCocktailDetailsViewController(with cocktail: Drink)
}

class ListRouter: ListRouterProtocol {
    
    unowned var view: ListViewController
    
    required init(view: ListViewController) {
        self.view = view
    }
    
    func openCocktailDetailsViewController(with cocktail: Drink) {
        print("Open detailsCocktail")
        Router.shared.openDetailsViewController(with: cocktail, viewController: self.view)
    }
    
    
}
