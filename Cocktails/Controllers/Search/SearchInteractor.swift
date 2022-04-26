//
//  SearchInteractor.swift
//  Cocktails
//
//  Created by Владимир Ли on 24.04.2022.
//

import Foundation

protocol SearchInteractorInputProtocol: AnyObject {
    init(presenter: SearchInteractorOutputProtocol)
    func provideData()
}

protocol SearchInteractorOutputProtocol {
    func recieveData()
}

class SearchInteractor {
    
    let presenter: SearchInteractorOutputProtocol
    
    required init(presenter: SearchInteractorOutputProtocol) {
        self.presenter = presenter
    }
}

extension SearchInteractor: SearchInteractorInputProtocol {
    
    func provideData() {
        print("VIPER is working")
        presenter.recieveData()
    }
}
