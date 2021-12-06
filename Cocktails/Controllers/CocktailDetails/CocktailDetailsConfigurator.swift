//
//  CocktailDetailsConfigurator.swift
//  Cocktails
//
//  Created by Владимир Ли on 22.11.2021.
//

import Foundation

protocol CocktailDetailsConfiguratorProtocol {
    func configure(with view: CocktailDetailsViewController)
}

class CocktailDetailsConfigurator: CocktailDetailsConfiguratorProtocol {
    
    func configure(with view: CocktailDetailsViewController) {
        let presenter = CocktailDetailsPresenter(view: view)
        let interactor = CocktailDetailsInteractor(presenter: presenter)
        
        view.presenter = presenter
        presenter.interactor = interactor
    }
}
