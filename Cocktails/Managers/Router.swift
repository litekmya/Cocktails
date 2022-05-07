//
//  Router.swift
//  Cocktails
//
//  Created by Владимир Ли on 08.05.2022.
//

import UIKit

class Router {
    
    static let shared = Router()
    
    private init () {}
    
    func openDetailsViewController(with cocktail: Drink, viewController: UIViewController) {
        let detailsViewController = CocktailDetailsViewController()
        detailsViewController.configurator.configure(with: detailsViewController)
        detailsViewController.title = cocktail.strDrink
        
        let cocktailData = CocktailData(cocktail: cocktail)
        detailsViewController.cocktailData = cocktailData
        
        DispatchQueue.main.async {
            guard let imageString = cocktail.strDrinkThumb else { return }
            let cocktailImage = NetworkManager.shared.fetchImage(from: imageString)
            
            detailsViewController.cocktailImage = cocktailImage
        }
        
        detailsViewController.presenter.requestData()
        
        viewController.navigationController?.pushViewController(detailsViewController, animated: true)
    }
}
