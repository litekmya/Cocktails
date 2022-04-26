//
//  ListConfigurator.swift
//  Cocktails
//
//  Created by Владимир Ли on 26.04.2022.
//

import Foundation

protocol ListConfiguratorProtocol {
    func configure(view: ListViewController)
}

class ListConfigurator: ListConfiguratorProtocol {
    
    func configure(view: ListViewController) {
        let presenter = ListPresenter(view: view)
        let interactor = ListInteractor(presenter: presenter)
        let router = ListRouter(view: view)
        
        view.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
