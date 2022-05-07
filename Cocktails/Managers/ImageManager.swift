//
//  ImageManager.swift
//  Cocktails
//
//  Created by Владимир Ли on 20.04.2022.
//

import Foundation
import UIKit

class ImageManager {
    
    static let shared = ImageManager()
    
    private init() {}
    
    func getImage(from url: URL, completion: @escaping (Data, URLResponse, UIImage) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let data = data, let response = response else { return }
            guard let responseURL = response.url else { return }
            guard responseURL == url else { return }
            
            guard let image = UIImage(data: data) else { return }
                        
            completion(data, response, image)
        }
    }
}
