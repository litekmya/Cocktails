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
    var sections: [ListAllCocktailsModel]!
    
    required init(view: ListViewInputProtocol) {
        self.view = view
    }
}

extension ListPresenter: ListViewOutputProtocol {

    func requestData() {
        interactor.provideData()
    }
    
    func requestSections() -> [ListAllCocktailsModel] {
        sections = interactor.provideSections()
        print("requestSections")
        return sections
    }
    
    func getHeader(with sectionNumber: Int, delegate: ExpandableHeaderViewDelegate) -> ExpandableHeaderView {
        let header = interactor.provideHeader(with: sectionNumber, delegate: delegate)
        return header
    }
}

extension ListPresenter: ListInteractorOutputProtocol {
    
    func recieveData() {
        view.setupTableView()
        print("recieveTableView")
    }
}
