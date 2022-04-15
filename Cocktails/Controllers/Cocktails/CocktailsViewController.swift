//
//  CocktailsViewController.swift
//  Cocktails
//
//  Created by Владимир Ли on 04.11.2021.
//

import UIKit

//MARK: - Viper protocols
protocol CocktailsViewInputProtocol: AnyObject {
    var collectionView: UICollectionView { get }
    
    func register(_ collectionView: UICollectionView)
    func setupNavigationBar()
    func appointDelegates()
    func createRefreshButton()
    func reloadData()
}

protocol CocktailsViewOutputProtocol {
    var cocktailsCount: Int { get }
    
    init(view:CocktailsViewInputProtocol)
    
    func requestData()
    func getCocktail(with indexPath: IndexPath) -> Drink
    func showCocktailDetails(at indexPath: Int, with cocktailImage: UIImage)
}

//MARK: - ViewController
class CocktailsViewController: UIViewController {
    
    //MARK: - Public properties
    var presenter: CocktailsViewOutputProtocol!
    
    let collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: CocktailsViewController.createLayout()
    )
    
    //MARK: - Private properties
    private let configurator: CocktailsConfiguratorProtocol = CocktailsConfigurator()
    private var shuffleButton: UIButton!
    private var cocktailDetails: CocktailData!
    private var cocktailImage: UIImage!
        
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configurator.configure(with: self)
        presenter.requestData()
    }
    
    @objc func refreshCoctails() {
        presenter.requestData()
    }
}

//MARK: - CocktailsViewInputProtocol
extension CocktailsViewController: CocktailsViewInputProtocol {
    
    func register(_ collectionView: UICollectionView) {
        view.addSubview(collectionView)
        
        collectionView.register(CocktailsViewCell.self, forCellWithReuseIdentifier: CocktailsViewCell.identifier)
        collectionView.frame = view.bounds
        collectionView.dataSource = self
        collectionView.isScrollEnabled = false
    }
    
    func appointDelegates() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func setupNavigationBar() {
        title = "Cocktails"
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func createRefreshButton() {
        let refreshButton = UIBarButtonItem(
            barButtonSystemItem: .refresh,
            target: self,
            action: #selector(refreshCoctails)
        )
        
        navigationItem.rightBarButtonItem = refreshButton
    }
    
    func reloadData() {
        collectionView.reloadData()
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension CocktailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.cocktailsCount - 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CocktailsViewCell.identifier, for: indexPath) as! CocktailsViewCell
        
        cell.imageView.image = nil
        cell.activityIndicator.startAnimating()
        
        let cocktail = presenter.getCocktail(with: indexPath)
        cell.getImage(from: cocktail) { image in
            self.cocktailImage = image
        }
        
        return cell
    }
    
    //MARK: - Did select item at
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.showCocktailDetails(at: indexPath.item, with: cocktailImage)
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

