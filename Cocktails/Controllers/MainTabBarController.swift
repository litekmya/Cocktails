//
//  MainTabBarController.swift
//  Cocktails
//
//  Created by Владимир Ли on 08.11.2021.
//

import Foundation
import UIKit

class MainTabBarController: UITabBarController  {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarController()
    }
    
    private func setupTabBarController() {
        let cocktailsViewController = createNavigationController(
            view: CocktailsViewController(),
            itemName: "CockTails",
            itemImage: "rectangle.on.rectangle.square"
        )
        let searchViewController = createNavigationController(
            view: SearchViewController(),
            itemName: "Search",
            itemImage: "text.magnifyingglass"
        )
        let favoriteViewController = createNavigationController(
            view: FavoriteViewController(),
            itemName: "Favorite", itemImage: "star"
        )
        
        tabBar.alpha = 0.93
        
        self.setViewControllers([favoriteViewController, cocktailsViewController, searchViewController], animated: true)
        self.selectedViewController = cocktailsViewController
    }
    
    private func createNavigationController(view: UIViewController, itemName: String, itemImage: String) -> UINavigationController {
        let item = UITabBarItem(title: itemName, image: UIImage(systemName: itemImage), tag: 0)
        
        let navigationController = UINavigationController(rootViewController: view)
        navigationController.tabBarItem = item
        
        return navigationController
    }
}
