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
    var router: CocktailsRouterProtocol!
    
    var cocktailDetails: CocktailData!
    var cocktailsCount: Int {
        cocktails.count
    }
    
    private var cocktails: [Drink] = []
    
    required init(view: CocktailsViewInputProtocol) {
        self.view = view
    }
}

//MARK: - CocktailsViewOutputProtocol
extension CocktailsPresenter: CocktailsViewOutputProtocol {
    
    func requestData() {
        interactor.provideDrinksData()
    }
    
    func getCocktail(with indexPath: IndexPath) -> Drink {
        cocktails[indexPath.item]
    }
    
    func showCocktailDetails(at indexPath: Int, with cocktailImage: UIImage) {
        let cocktail = cocktails[indexPath]
        
        router.openCocktailDetailsViewController(with: cocktail)
    }
}

//MARK: - CocktailsInteractorOutputProtocol
extension CocktailsPresenter: CocktailsInteractorOutputProtocol {
    
    func customizeView() {
        view.register(view.collectionView)
        view.setupNavigationBar()
        view.appointDelegates()
        view.createRefreshButton()
    }
    
    func receiveDrinksData(_ cocktailsData: [Drink]) {
        cocktails = cocktailsData
        
        view.reloadData()
    }
}
