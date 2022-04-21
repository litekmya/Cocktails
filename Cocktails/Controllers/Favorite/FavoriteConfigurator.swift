//
//  FavoriteConfigurator.swift
//  Cocktails
//
//  Created by Владимир Ли on 19.04.2022.
//

import Foundation

protocol FavoriteConfiguratorProtocol {
    func configure(with view: FavoriteViewController)
}

class FavoriteConfigurator: FavoriteConfiguratorProtocol {
    
    func configure(with view: FavoriteViewController) {
        let presenter = FavoritePresenter(view: view)
        let interactor = FavoriteInteractor(presenter: presenter)
        let router = FavoriteRouter(viewController: view)
        
        view.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
