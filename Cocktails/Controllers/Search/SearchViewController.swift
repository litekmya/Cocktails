//
//  SearchViewController.swift
//  Cocktails
//
//  Created by Владимир Ли on 08.11.2021.
//

import UIKit

protocol SearchViewInputProtocol: AnyObject {
    func setupSearchController()
}

protocol SearchViewOutputProtocol {
    init(view: SearchViewInputProtocol)
    func requestData()
}

class SearchViewController: UIViewController, UISearchBarDelegate {
    
    //MARK: - Public properties
    var presenter: SearchViewOutputProtocol!
    let configurator: SearchConfiguratorProtocol = SearchConfigurator()
    
    //MARK: - Private properties
    private let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.requestData()
        
        view.backgroundColor = .white
        title = "Cocktail search"
        
    }
}

extension SearchViewController: SearchViewInputProtocol {
    
    func setupSearchController() {
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
    }
}
