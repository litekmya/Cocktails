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
    func setupTitleLabel()
    func setupImageView()
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
    
    //MARK: - private properties
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let titleLabel = UILabel()
    private let imageView = UIImageView()
    private let ingredientsLabel = UILabel()
    private let descriptionTextView = UITextView()

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.contentSize = contentView.frame.size
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
        
        scrollView.contentSize = contentView.frame.size
    }
    
    func setupTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel
    }
    
    func setupImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.widthAnchor.constraint(equalToConstant: view.frame.width - 60).isActive = true
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor).isActive = true
        
        imageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 30).isActive = true
        imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 30).isActive = true
        imageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -30).isActive = true
        imageView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    
        imageView.backgroundColor = .blue
        imageView.image = cocktailImage
    }
}
