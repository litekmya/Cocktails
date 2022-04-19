//
//  FavoriteInteractor.swift
//  Cocktails
//
//  Created by Владимир Ли on 19.04.2022.
//

import Foundation

protocol FavoriteInteractorInputProtocol: AnyObject {
    init(presenter: FavoriteInteractorOutputProtocol)
    func provideData()
}

protocol FavoriteInteractorOutputProtocol {
    func customizeView()
    func recieveData(_ favoriteCocktails: [Cocktail])
}

class FavoriteInteractor: FavoriteInteractorInputProtocol {
    
    var presenter: FavoriteInteractorOutputProtocol
    
    private let coreDataManager = CoreDataManager.shared
    
    required init(presenter: FavoriteInteractorOutputProtocol) {
        self.presenter = presenter
    }
    
    func provideData() {
        
        let favoriteCocktails = coreDataManager.fetchData()
        print(favoriteCocktails.count)
        
        presenter.customizeView()
        presenter.recieveData(favoriteCocktails)
    }
}

