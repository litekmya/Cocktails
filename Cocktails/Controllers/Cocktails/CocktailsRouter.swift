//
//  CocktailsRouter.swift
//  Cocktails
//
//  Created by Владимир Ли on 05.11.2021.
//

import Foundation
import UIKit

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
        cocktailDetailsViewController.configurator.configure(with: cocktailDetailsViewController)
        cocktailDetailsViewController.title = cocktail.strDrink
        cocktailDetailsViewController.cocktail = cocktail
        
        guard let imageString = cocktail.strDrinkThumb else { return }
        let cocktailImage = NetworkManager.shared.fetchImage(from: imageString)
        
        let cocktailData = CocktailData(cocktail: cocktail)
        
        cocktailDetailsViewController.cocktailData = cocktailData
        
        cocktailDetailsViewController.cocktailImage = cocktailImage
        cocktailDetailsViewController.presenter.requestData()

        self.viewController.navigationController?.pushViewController(cocktailDetailsViewController, animated: true)
    }
}
