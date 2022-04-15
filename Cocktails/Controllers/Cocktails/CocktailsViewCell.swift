//
//  CocktailsViewCell.swift
//  Cocktails
//
//  Created by Владимир Ли on 07.11.2021.
//

import UIKit

class CocktailsViewCell: UICollectionViewCell {
    
    static let identifier = "CocktailsViewCell"
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 9
        imageView.contentMode = .scaleAspectFill

        return imageView
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .large
        activityIndicator.hidesWhenStopped = true
        
        return activityIndicator
    }()
    
    private let networkManager = NetworkManager.shared

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.addSubview(activityIndicator)
        contentView.clipsToBounds = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds
        activityIndicator.frame = contentView.bounds
    }
    
    func getImage(from cocktail: Drink, with completion: @escaping(UIImage) -> Void) {
        DispatchQueue.global().async {
            guard let imageURL = cocktail.strDrinkThumb else { return }
            let image = self.networkManager.fetchImage(from: imageURL)
            
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.imageView.image = image
                
                completion(image)
            }
        }
    }
//
//    func getImage(from image: UIImage) {
//        DispatchQueue.main.async {
//            self.activityIndicator.stopAnimating()
//            self.imageView.image = image
//        }
//    }
}
