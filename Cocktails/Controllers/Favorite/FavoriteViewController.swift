//
//  FavoriteViewController.swift
//  Cocktails
//
//  Created by Владимир Ли on 19.04.2022.
//

import UIKit

protocol FavoriteViewInputProtocol: AnyObject {
    func customizeTableView()
}

protocol FavoriteViewOutputProtocol {
    var favoriteCocktails: [Cocktail] { get }
    
    func provideData()
    func getFavoriteCocktails() -> [Cocktail]
    func showCocktailDetails(at indexPath: Int, and image: UIImage)
}

class FavoriteViewController: UITableViewController {
    
    //MARK: - Public properties
    var presenter: FavoriteViewOutputProtocol!
    let configurator: FavoriteConfiguratorProtocol = FavoriteConfigurator()
    
    //MARK: - private properties
    private let cellID = "cell"
    private var favoriteCocktails: [Cocktail] = []

    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.provideData()
        favoriteCocktails = presenter.getFavoriteCocktails()
        tableView.reloadData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    //MARK: - Private methods
    private func getImage(imageString: String?, completion: @escaping(UIImage) -> Void) {
        guard let imageString = imageString else { return }
        let image = UIImage()
        guard let newImage = image.fetchImage(from: imageString) else { return }
        
        completion(newImage)
    }
}

//MARK: - Table view Data Source, Delegate
extension FavoriteViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favoriteCocktails.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)

        let favoriteCocktail = favoriteCocktails[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.imageProperties.cornerRadius = 10
        content.imageProperties.reservedLayoutSize = CGSize(width: 70, height: 70)
        content.text = favoriteCocktail.title
        content.image = UIImage(systemName: "star.fill")
        
        guard let imageString = favoriteCocktail.imageString else { return cell }
        
        getImage(imageString: imageString) { image in
            content.image = image
            cell.contentConfiguration = content
        }
                
        cell.contentConfiguration = content
        
        return cell
    }
    
    //MARK: - Did select at
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favoriteCocktail = favoriteCocktails[indexPath.row]
        guard let imageString = favoriteCocktail.imageString else { return }
        
        getImage(imageString: imageString) { image in
            self.presenter.showCocktailDetails(at: indexPath.row, and: image)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let favoriteCocktail = favoriteCocktails[indexPath.row]
            CoreDataManager.shared.deleteFavorite(cocktail: favoriteCocktail)
            favoriteCocktails.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

//MARK: - FavoriteViewInputProtocol
extension FavoriteViewController: FavoriteViewInputProtocol {
    
    func customizeTableView() {
        title = "Favorite"
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
    }
}
