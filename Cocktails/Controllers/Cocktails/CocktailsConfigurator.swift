//
//  CocktailsConfigurator.swift
//  Cocktails
//
//  Created by Владимир Ли on 05.11.2021.
//

import Foundation

protocol CocktailsConfiguratorProtocol {
    func configure(with view: CocktailsViewController)
}

class CocktailsConfigurator: CocktailsConfiguratorProtocol {
    
    func configure(with view: CocktailsViewController) {
        let presenter = CocktailsPresenter(view: view)
        let interactor = CocktailsInteractor(presenter: presenter)
        let router = CocktailsRouter(viewController: view)
        
        view.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
