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
    func provideSections() -> [ListAllCocktailsModel]
    func provideHeader(with sectionNumber: Int, delegate: ExpandableHeaderViewDelegate) -> ExpandableHeaderView
}

protocol ListInteractorOutputProtocol: AnyObject  {
    func recieveData()
}

class ListInteractor {
    
    unowned var presenter: ListInteractorOutputProtocol
    
    private var sections: [ListAllCocktailsModel]!
    
    required init(presenter: ListInteractorOutputProtocol) {
        self.presenter = presenter
    }
}

extension ListInteractor: ListInteractorInputProtocol {
    
    func provideData() {
        presenter.recieveData()
    }
    
    func provideSections() -> [ListAllCocktailsModel] {
        sections = ListAllCocktailsModel.sections.sorted { $0.sectionName < $1.sectionName }
        
        return sections
    }
    
    func provideHeader(with sectionNumber: Int, delegate: ExpandableHeaderViewDelegate) -> ExpandableHeaderView {
        let header = ExpandableHeaderView()
        header.setupHeaderView(
            with: sections[sectionNumber].sectionName,
            sectionNumber: sectionNumber,
            expanded: sections[sectionNumber].expanded, delegate: delegate
        )
        
        return header
    }
}
