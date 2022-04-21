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
    func showCocktailDetails(at indexPath: Int)
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
    
    //MARK: - Private methods
    private func getImage(imageString: String?, completion: @escaping(UIImage) -> Void) {
        DispatchQueue.global().async {
            guard let imageString = imageString else { return }
            
            let image = NetworkManager.shared.fetchImage(from: imageString)
            
            DispatchQueue.main.async {
                completion(image)
            }
        }
    }
}

//MARK: - Table view Data Source, Delegate
extension FavoriteViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.favoriteCocktails.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)

        let favoriteCocktails = presenter.getFavoriteCocktails()
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
        presenter.showCocktailDetails(at: indexPath.row)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK: - FavoriteViewInputProtocol
extension FavoriteViewController: FavoriteViewInputProtocol {
    
    func customizeTableView() {
        title = "Favorite"
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
    }
}
