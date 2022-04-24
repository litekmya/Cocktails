//
//  FavoriteRouter.swift
//  Cocktails
//
//  Created by Владимир Ли on 19.04.2022.
//

import Foundation
import UIKit

protocol FavoriteRouterProtocol {
    init(viewController: FavoriteViewController)
    
    func openCocktailDetailsViewController(with cocktail: Cocktail, and image: UIImage)
}

class FavoriteRouter: FavoriteRouterProtocol {
    
    unowned let viewController: FavoriteViewController
    
    required init(viewController: FavoriteViewController) {
        self.viewController = viewController
    }
    
    func openCocktailDetailsViewController(with cocktail: Cocktail, and image: UIImage) {
        let cocktailDetailsViewController = CocktailDetailsViewController()
        cocktailDetailsViewController.configurator.configure(with: cocktailDetailsViewController)
        cocktailDetailsViewController.title = cocktail.title
        
        let cocktailData = CocktailData(cocktail: cocktail)
        cocktailDetailsViewController.cocktailData = cocktailData
        
        DispatchQueue.main.async {
            cocktailDetailsViewController.cocktailImage = image
        }
        
        cocktailDetailsViewController.presenter.requestData()

        self.viewController.navigationController?.pushViewController(cocktailDetailsViewController, animated: true)
    }
}
