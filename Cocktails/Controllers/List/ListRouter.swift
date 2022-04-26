//
//  ListRouter.swift
//  Cocktails
//
//  Created by Владимир Ли on 26.04.2022.
//

import UIKit

protocol ListRouterProtocol {
    init(view: ListViewController)
    
    func openCocktailDetailsViewController(with cocktail: Cocktail, and image: UIImage)
}

class ListRouter: ListRouterProtocol {
    
    unowned var view: ListViewController
    
    required init(view: ListViewController) {
        self.view = view
    }
    
    func openCocktailDetailsViewController(with cocktail: Cocktail, and image: UIImage) {
        print("Open detailsCocktail")
    }
    
    
}
