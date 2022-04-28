//
//  ListPresenter.swift
//  Cocktails
//
//  Created by Владимир Ли on 26.04.2022.
//

import Foundation

class ListPresenter {
    
    unowned var view: ListViewInputProtocol
    var interactor: ListInteractorInputProtocol!
    var router: ListRouterProtocol!
    
    required init(view: ListViewInputProtocol) {
        self.view = view
    }
}

extension ListPresenter: ListViewOutputProtocol {
    
    func requestData() {
        interactor.provideData()
    }
}

extension ListPresenter: ListInteractorOutputProtocol {
    
    func recieveData() {
        print("List view VIPER is worked")
        view.setupTableView()
    }
}
