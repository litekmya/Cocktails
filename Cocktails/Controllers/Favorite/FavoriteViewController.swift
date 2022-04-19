//
//  FavoriteViewController.swift
//  Cocktails
//
//  Created by Владимир Ли on 19.04.2022.
//

import UIKit

protocol FavoriteViewInputProtocol: AnyObject {
    func customizeTableView()
    func reloadData()
}

protocol FavoriteViewOutputProtocol {
    var favoriteCocktails: [Cocktail] { get }
    
    func provideData()
    func getFavoriteCocktails() -> [Cocktail]
}

class FavoriteViewController: UITableViewController {
    
    //MARK: - Public properties
    var presenter: FavoriteViewOutputProtocol!
    let configurator: FavoriteConfiguratorProtocol = FavoriteConfigurator()
    
    //MARK: - private properties
    private let cellID = "cell"
    private let favoriteCocktails: [Cocktail] = []

    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
//        presenter.provideData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.provideData()
        tableView.reloadData()
        print("will")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("did")
    }
}

//MARK: - Table view Data Source, Delegate
extension FavoriteViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        presenter.favoriteCocktails.count
        let count = presenter.getFavoriteCocktails()
        return count.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)

        let favoriteCocktails = presenter.getFavoriteCocktails()
        let favoriteCocktail = favoriteCocktails[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.image = UIImage(systemName: "star")
        content.text = favoriteCocktail.title        
        
        cell.contentConfiguration = content
                
        return cell
    }
}

//MARK: - FavoriteViewInputProtocol
extension FavoriteViewController: FavoriteViewInputProtocol {
    
    func customizeTableView() {
        title = "Favorite"
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
    }
    
    func reloadData() {
        tableView.reloadData()
    }
}
