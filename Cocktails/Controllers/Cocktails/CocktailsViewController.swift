//
//  CocktailsViewController.swift
//  Cocktails
//
//  Created by Владимир Ли on 04.11.2021.
//

import UIKit

//MARK: - Viper protocols
protocol CocktailsViewInputProtocol: AnyObject {
    var cocktails: [Drink] { get set }
    func setCocktails(_ cocktails: [Drink])
}

protocol CocktailsViewOutputProtocol {
    init(view:CocktailsViewInputProtocol)
    func requestData()
}

class CocktailsViewController: UIViewController {
    
    //MARK: - Public properties
    var presenter: CocktailsViewOutputProtocol!
    var cocktails: [Drink] = []
    var cocktailsImages: [UIImage] = []
    
    let collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: CocktailsViewController.createLayout()
    )
    
    //MARK: - Private properties
    private let configurator: CocktailsConfiguratorProtocol = CocktailsConfigurator()
    private var shuffleButton: UIButton!
        
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        register(collectionView)
        setupNavigationBar()
        
        configurator.configure(with: self)
        presenter.requestData()
    }
    
    //MARK: - Private methods
    private func setupNavigationBar() {
        title = "Cocktails"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let refreshButton = UIBarButtonItem(
            barButtonSystemItem: .refresh,
            target: self,
            action: #selector(refreshCoctails))
        
        navigationItem.rightBarButtonItem = refreshButton
    }
    
    @objc func refreshCoctails() {
        presenter.requestData()
    }
    
    private func register(_ collectionView: UICollectionView) {
        view.addSubview(collectionView)
        
        collectionView.register(CocktailsViewCell.self, forCellWithReuseIdentifier: CocktailsViewCell.identifier)
        collectionView.frame = view.bounds
        collectionView.dataSource = self
        collectionView.isScrollEnabled = false
    }
}

//MARK: - CocktailsViewInputProtocol
extension CocktailsViewController: CocktailsViewInputProtocol {
    
    //MARK: - !!! Исправить данный метод, если в будущем нам не понадобятся данные [Drink]
    func setCocktails(_ cocktails: [Drink]) {
        collectionView.reloadData()
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension CocktailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cocktails.count - 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CocktailsViewCell.identifier, for: indexPath) as! CocktailsViewCell
        let cocktail = cocktails[indexPath.item]
        
        cell.getImage(from: cocktail)
        
        return cell
    }
    
    //MARK: - Create Layout
    static func createLayout() -> UICollectionViewCompositionalLayout {
        let bigItemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(2/3),
            heightDimension: .fractionalHeight(1)
        )
        let smallItemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(2)
        )
        
        let mainGroupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        let smallGroupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1/3),
            heightDimension: .fractionalHeight(1)
        )
        
        let bigGroupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(0.235))
        
        let bigItem = NSCollectionLayoutItem(layoutSize: bigItemSize)
        bigItem.contentInsets = NSDirectionalEdgeInsets(top: 3, leading: 3, bottom: 3, trailing: 3)
        
        let smallItem = NSCollectionLayoutItem(layoutSize: smallItemSize)
        smallItem.contentInsets = NSDirectionalEdgeInsets(top: 3, leading: 3, bottom: 3, trailing: 3)
        
        let subGroup = NSCollectionLayoutGroup.vertical(layoutSize: smallGroupSize, subitem: smallItem, count: 2)
        
        let upperSubGroup = NSCollectionLayoutGroup.horizontal(layoutSize: bigGroupSize, subitems: [subGroup, bigItem])
        let bottomSubGroup = NSCollectionLayoutGroup.horizontal(layoutSize: bigGroupSize, subitems: [bigItem, subGroup])
        
        let mainGroup = NSCollectionLayoutGroup.vertical(layoutSize: mainGroupSize,
                                                          subitems: [upperSubGroup, bottomSubGroup])

        let section = NSCollectionLayoutSection(group: mainGroup)
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
}

