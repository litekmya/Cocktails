//
//  CocktailsPresenter.swift
//  Cocktails
//
//  Created by Владимир Ли on 05.11.2021.
//

import Foundation
import UIKit

class CocktailsPresenter {
    
    unowned var view: CocktailsViewInputProtocol
    var interactor: CocktailsInteractorInputProtocol!
    var router: CocktailsRouterInputProtocol!
    var cocktailsCount: Int {
        cocktails.count
    }
    
    private var cocktails: [Drink] = []
    
    required init(view: CocktailsViewInputProtocol) {
        self.view = view
    }
}

extension CocktailsPresenter: CocktailsViewOutputProtocol {
    
    func requestData() {
        interactor.provideDrinksData()
    }
    
    func getCocktail(with indexPath: IndexPath) -> Drink {
        cocktails[indexPath.item]
    }
    
    func showCocktailDetails(at indexPath: IndexPath) {
        let cocktail = cocktails[indexPath.item]
        print("Метод из пресентера")
        
        router.openCocktailDetailsViewController(with: cocktail)
    }
}

extension CocktailsPresenter: CocktailsInteractorOutputProtocol {
    func receiveDrinksData(_ cocktailsData: [Drink]) {
        view.register(view.collectionView)
        view.setupNavigationBar()
        view.appointDelegates()
        view.createRefreshButton()
        
        cocktails = cocktailsData
        
        view.reloadData()
    }
}
