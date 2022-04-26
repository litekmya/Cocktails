//
//  SearchPresenter.swift
//  Cocktails
//
//  Created by Владимир Ли on 24.04.2022.
//

import Foundation

class SearchPresenter {
    
    unowned let view: SearchViewInputProtocol
    var interactor: SearchInteractorInputProtocol!
    var router: SearchRouterProtocol!
    
    required init(view: SearchViewInputProtocol) {
        self.view = view
        }
}

extension SearchPresenter: SearchViewOutputProtocol {
    
    func requestData() {
        interactor.provideData()
    }
    
}

extension SearchPresenter: SearchInteractorOutputProtocol {
    
    func recieveData() {
        print("Данные пришли в presenter")
        view.setupSearchController()
    }
}
