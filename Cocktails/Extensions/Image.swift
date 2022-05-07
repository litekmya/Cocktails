//
//  ImageView.swift
//  Cocktails
//
//  Created by Владимир Ли on 20.04.2022.
//

import UIKit

extension UIImage {
    
    func fetchImage(from url: String) -> UIImage? {
        var image: UIImage?
        guard let imageURL = URL(string: url) else {
            return UIImage(systemName: "star")
        }
        
        if let cachedImage = getCachedImage(from: imageURL) {
            print("Получили картинку из кэша")
            return cachedImage
        }
        
        ImageManager.shared.getImage(from: imageURL) { data, response, newImage in
            DispatchQueue.main.async {
                image = newImage
            }
            
            self.saveDataToCache(with: data, and: response)
        }
        
        return image

    }
    
    private func getCachedImage(from url: URL) -> UIImage? {
        let urlRequest = URLRequest(url: url)
        
        if let cachedResponse = URLCache.shared.cachedResponse(for: urlRequest) {
            return UIImage(data: cachedResponse.data)
        }
                
        return nil
    }
    
    private func saveDataToCache(with data: Data, and response: URLResponse) {
        guard let urlResponse = response.url else { return }
        let urlRequest = URLRequest(url: urlResponse)
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: urlRequest)
    }
}
