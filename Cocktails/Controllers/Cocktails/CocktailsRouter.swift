//
//  CocktailsRouter.swift
//  Cocktails
//
//  Created by Владимир Ли on 05.11.2021.
//

import Foundation
import UIKit

enum Segues: String {
    case showCocktailDetails = "showDetails"
}

protocol CocktailsRouterInputProtocol {
    init(viewController:  CocktailsViewController)
    
    func openCocktailDetailsViewController(with cocktail: Drink)
}

class CocktailsRouter: CocktailsRouterInputProtocol {
    
    unowned let viewController: CocktailsViewController
    
    required init(viewController: CocktailsViewController) {
        self.viewController = viewController
    }
    
    func openCocktailDetailsViewController(with cocktail: Drink) {
        let cocktailDetailsViewController = CocktailDetailsViewController()
        cocktailDetailsViewController.title = "cocktailDetailsViewController"
        cocktailDetailsViewController.cocktail = cocktail
        cocktailDetailsViewController
        
        self.viewController.navigationController?.pushViewController(cocktailDetailsViewController, animated: true)

    }
}
