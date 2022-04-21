//
//  CocktailDetailsViewController.swift
//  Cocktails
//
//  Created by Владимир Ли on 08.11.2021.
//

import UIKit
import CoreData

protocol CocktailDetailsViewInputProtocol: AnyObject {
    func setupView()
    func setupScrollView()
    func setupContentView()
    func setupImageView()
    func setupACtivityIndicator()
    func setupFavoriteButton()
    
    func setupInstructionsLabel()
    func setupIngedientslabel()
    func setupCocktailTypeLabels()
    func setupGlassLabel()
}

protocol CocktailDetailsViewOutputProtocol {
    init(view: CocktailDetailsViewInputProtocol)
    
    func requestData()
}

class CocktailDetailsViewController: UIViewController, UIScrollViewDelegate {
    
    //MARK: - Public properties
    var presenter: CocktailDetailsViewOutputProtocol!
    var configurator: CocktailDetailsConfiguratorProtocol = CocktailDetailsConfigurator()
    
//    var cocktail: Drink!
    var cocktailImage: UIImage!
    var cocktailData: CocktailData!
    
    //MARK: - private properties
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let imageView = UIImageView()
    private let activityIndicator = UIActivityIndicatorView()
    
    private let ingredientsStaticLabel = UILabel()
    private let glassStaticLabel = UILabel()
    private let cocktailTypeStaticLabel = UILabel()
    
    private let ingredientsLabel = UILabel()
    private let glassLabel = UILabel()
    private let cocktailTypeLabel = UILabel()
    
    private let instructionsLabel = UILabel()
    
    private var favoriteButton: UIBarButtonItem!
    private let starImage = UIImage(systemName: "star")
    private let fillStarImage = UIImage(systemName: "star.fill")
    
    private var newFavoriteCocktail: Cocktail!
    
    private var coreDataManager = CoreDataManager.shared

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
    }
}

//MARK: - CocktailDetailsViewInputProtocol
extension CocktailDetailsViewController: CocktailDetailsViewInputProtocol {
    
    //MARK: - Layout
    func setupView() {
        view.addSubview(scrollView)
    }
    
    func setupScrollView() {
        scrollView.delegate = self
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        scrollView.addSubview(contentView)
    }
    
    func setupContentView() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        
        contentView.addSubview(imageView)
        contentView.addSubview(instructionsLabel)
        contentView.addSubview(ingredientsStaticLabel)
        contentView.addSubview(ingredientsLabel)
        contentView.addSubview(cocktailTypeStaticLabel)
        contentView.addSubview(cocktailTypeLabel)
        contentView.addSubview(glassStaticLabel)
        contentView.addSubview(glassLabel)
        
        scrollView.contentSize = contentView.frame.size
    }
    
    func setupImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.widthAnchor.constraint(equalToConstant: view.frame.width - 60).isActive = true
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor).isActive = true
        
        imageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 30).isActive = true
        imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 30).isActive = true
        imageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -30).isActive = true
    
        imageView.contentMode = .scaleAspectFill
        imageView.addSubview(activityIndicator)
        
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.imageView.image = self.cocktailImage
            
        }
    }
    
    func setupACtivityIndicator() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        activityIndicator.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
        
        activityIndicator.startAnimating()
        activityIndicator.style = .medium
        activityIndicator.hidesWhenStopped = true
    }
    
    func setupInstructionsLabel() {
        setup(label: instructionsLabel, imageView, cocktailData.instruction, false)
    }
    
    func setupIngedientslabel() {
        setupStatic(label: ingredientsStaticLabel, instructionsLabel, "Ingredients:")
        setup(label: ingredientsLabel, ingredientsStaticLabel, getIngredients(), false)
    }
    
    func setupCocktailTypeLabels() {
        setupStatic(label: cocktailTypeStaticLabel, ingredientsLabel, "Cocktail type:")
        setup(label: cocktailTypeLabel, cocktailTypeStaticLabel, cocktailData.alcoholic, false)
    }
    
    func setupGlassLabel() {
        setupStatic(label: glassStaticLabel, cocktailTypeLabel, "Glass:")
        setup(label: glassLabel, glassStaticLabel, cocktailData.glass, true)
    }
    
    func setupFavoriteButton() {
        let starImage = UIImage(systemName: "star")
        
        favoriteButton = UIBarButtonItem(image: starImage, style: .done, target: self, action: #selector(addToFavorite))
        
        checkData(cocktail: cocktailData) { favoriteCocktail in
            favoriteButton = UIBarButtonItem(image: fillStarImage, style: .done, target: self, action: #selector(addToFavorite))
            
            newFavoriteCocktail = favoriteCocktail

        }
        
        navigationItem.rightBarButtonItem = favoriteButton
    }
    
    //MARK: - @objc
    @objc func addToFavorite() {
        if favoriteButton.image == starImage {
            favoriteButton.image = fillStarImage
            coreDataManager.saveFavorite(from: cocktailData, ingredients: ingredientsLabel.text) { cocktail in
                newFavoriteCocktail = cocktail
            }
        } else {
            favoriteButton.image = starImage
            coreDataManager.deleteFavorite(cocktail: newFavoriteCocktail)
        }
    }
    
    //MARK: - Private Methods
    private func setupStatic(label: UILabel, _ topView: UIView, _ title: String) {
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.widthAnchor.constraint(equalTo: topView.widthAnchor).isActive = true
        
        label.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 20).isActive = true
        label.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        label.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16).isActive = true
        
        label.text = title
        label.font = UIFont(descriptor: .preferredFontDescriptor(withTextStyle: .headline), size: 20)
    }
    
    private func setup(label: UILabel, _ topView: UIView, _ text: String, _ bottomIsActive: Bool?) {
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 6).isActive = true
        label.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        label.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16).isActive = true
        label.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = bottomIsActive ?? true
        
        label.text = text
        label.numberOfLines = 20
    }
    
    private func getIngredients() -> String {
        var ingredientsAndMeasure = ""
        
        for index in 0..<cocktailData.ingredients.count {
            if !cocktailData.ingredients[index].isEmpty && !cocktailData.measures.isEmpty {
                ingredientsAndMeasure += cocktailData.ingredients[index] + "-" + cocktailData.measures[index] + "\n"
            } else {
                ingredientsAndMeasure = cocktailData.ingredients[index]
            }
        }
        
        return ingredientsAndMeasure
    }
    
    private func checkData(cocktail: CocktailData, completion: (Cocktail) -> Void) {
        let favoriteCocktails = coreDataManager.fetchData()
        
        for favoriteCocktail in favoriteCocktails {
            let favoriteCocktailData = CocktailData(cocktail: favoriteCocktail)
            
            if cocktail.title == favoriteCocktailData.title {
                completion(favoriteCocktail)
            }
        }
    }
}
