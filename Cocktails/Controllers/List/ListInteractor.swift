//
//  ListInteractor.swift
//  Cocktails
//
//  Created by Владимир Ли on 26.04.2022.
//

import Foundation

protocol ListInteractorInputProtocol {
    init(presenter: ListInteractorOutputProtocol)
    func provideData()
}

protocol ListInteractorOutputProtocol: AnyObject  {
    func recieveData()
}

class ListInteractor {
    
    unowned var presenter: ListInteractorOutputProtocol
    
    required init(presenter: ListInteractorOutputProtocol) {
        self.presenter = presenter
    }
}

extension ListInteractor: ListInteractorInputProtocol {
    
    func provideData() {
        presenter.recieveData()
    }
}
