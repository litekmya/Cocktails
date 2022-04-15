//
//  CocktailDetailsViewController.swift
//  Cocktails
//
//  Created by Владимир Ли on 08.11.2021.
//

import UIKit

protocol CocktailDetailsViewInputProtocol: AnyObject {
    func setupView()
    func setupScrollView()
    func setupContentView()
    func setupImageView()
    
    func setupInstructionsLabel()
    func setupIngedientsStaticlabel()
    func setupIngredientsLabel()
}

protocol CocktailDetailsViewOutputProtocol {
    init(view: CocktailDetailsViewInputProtocol)
    
    func requestData()
}

class CocktailDetailsViewController: UIViewController, UIScrollViewDelegate {
    
    //MARK: - Public properties
    var presenter: CocktailDetailsViewOutputProtocol!
    var configurator: CocktailDetailsConfiguratorProtocol = CocktailDetailsConfigurator()
    var cocktail: Drink!
    var cocktailImage: UIImage!
    var cocktailData: CocktailData!
    
    //MARK: - private properties
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let imageView = UIImageView()
    
    private let ingredientsStaticLabel = UILabel()
    private let glassStaticLabel = UILabel()
    private let drinkTypeStaticLabel = UILabel()
    
    private let ingredientsLabel = UILabel()
    private let glassLabel = UILabel()
    private let drinkTypeLabel = UILabel()
    
    private let instructionsLabel = UILabel()

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
    }
}

//MARK: - CocktailDetailsViewInputProtocol
extension CocktailDetailsViewController: CocktailDetailsViewInputProtocol {
    
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
        
        scrollView.contentSize = contentView.frame.size
    }
    
    func setupImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.widthAnchor.constraint(equalToConstant: view.frame.width - 60).isActive = true
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor).isActive = true
        
        imageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 30).isActive = true
        imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 30).isActive = true
        imageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -30).isActive = true
//        imageView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    
        imageView.backgroundColor = .blue
        imageView.image = cocktailImage
        imageView.contentMode = .scaleAspectFill
    }
    
    func setupInstructionsLabel() {
        instructionsLabel.translatesAutoresizingMaskIntoConstraints = false
            
        instructionsLabel.widthAnchor.constraint(equalToConstant: contentView.frame.width - 32).isActive = true
        
        instructionsLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16).isActive = true
        instructionsLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        instructionsLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16).isActive = true
//        instructionsLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        
        instructionsLabel.numberOfLines = 30
        
        instructionsLabel.text = cocktailData.instruction
    }
    
    func setupIngedientsStaticlabel() {
        ingredientsStaticLabel.translatesAutoresizingMaskIntoConstraints = false
        
        ingredientsStaticLabel.widthAnchor.constraint(equalTo: instructionsLabel.widthAnchor).isActive = true
        
        ingredientsStaticLabel.topAnchor.constraint(equalTo: instructionsLabel.bottomAnchor, constant: 20).isActive = true
        ingredientsStaticLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        ingredientsStaticLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16).isActive = true
//        ingredientsStaticLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        
        ingredientsStaticLabel.text = "Ingredients:"
        ingredientsStaticLabel.font = UIFont(descriptor: .preferredFontDescriptor(withTextStyle: .body), size: 20)
    }
    
    func setupIngredientsLabel() {
        ingredientsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        ingredientsLabel.topAnchor.constraint(equalTo: ingredientsStaticLabel.bottomAnchor, constant: 6).isActive = true
        ingredientsLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        ingredientsLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16).isActive = true
        ingredientsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant:  -16).isActive = true
        
        ingredientsLabel.text = getIngredients()
        
        ingredientsLabel.numberOfLines = 20
    }
    
    private func setupStatic(label: UILabel, _ view: UIView, _ title: String) {
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        label.topAnchor.constraint(equalTo: view.bottomAnchor, constant: 20).isActive = true
        label.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        label.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16).isActive = true
        
        label.text = title
        label.font = UIFont(descriptor: .preferredFontDescriptor(withTextStyle: .body), size: 20)
    }
    
    private func getIngredients() -> String{
        var ingredientsAndMeasure = ""
        
        for index in 0..<cocktailData.ingredients.count {
            if !cocktailData.ingredients[index].isEmpty {
                ingredientsAndMeasure += cocktailData.ingredients[index] + "-" + cocktailData.measures[index] + "\n"
            }
        }
        
        return ingredientsAndMeasure
    }
}
