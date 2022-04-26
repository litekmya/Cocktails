//
//  SearchRouter.swift
//  Cocktails
//
//  Created by Владимир Ли on 24.04.2022.
//

import UIKit

protocol SearchRouterProtocol {
    init(view: SearchViewController)
    
    func openCocktailDetailsViewController(with cocktail: Cocktail, and image: UIImage)
}

class SearchRouter: SearchRouterProtocol {
    
    unowned let view: SearchViewController
    
    required init(view: SearchViewController) {
        self.view = view
    }
    
    func openCocktailDetailsViewController(with cocktail: Cocktail, and image: UIImage) {
        
    }
}
