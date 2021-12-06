//
//  CocktailDetailsViewController.swift
//  Cocktails
//
//  Created by Владимир Ли on 08.11.2021.
//

import UIKit

protocol CocktailDetailsViewInputProtocol: AnyObject {
    
}

protocol CocktailDetailsViewOutputProtocol {
    init(view: CocktailDetailsViewInputProtocol)
}

class CocktailDetailsViewController: UIViewController {
    
    //MARK: - Public properties
    var presenter: CocktailDetailsViewOutputProtocol!
    var cocktail: Drink!
    
    //MARK: - private properties
    private let imageView = UIImageView()
    private let ingredientsLabel = UILabel()
    private let descriptionTextView = UITextView()
    
    

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        print(cocktail)
        view.backgroundColor = .red
    }

}

extension CocktailDetailsViewController: CocktailDetailsViewInputProtocol {
    
}
