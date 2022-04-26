//
//  SearchConfigurator.swift
//  Cocktails
//
//  Created by Владимир Ли on 24.04.2022.
//

import Foundation

protocol SearchConfiguratorProtocol {
    func configure(with view: SearchViewController)
}

class SearchConfigurator: SearchConfiguratorProtocol {
    
    func configure(with view: SearchViewController) {
        let presenter = SearchPresenter(view: view)
        let interactor = SearchInteractor(presenter: presenter)
        let router = SearchRouter(view: view)
        
        view.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
