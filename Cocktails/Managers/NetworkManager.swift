//
//  AlamofireManager.swift
//  Cocktails
//
//  Created by Владимир Ли on 08.11.2021.
//

import Foundation
import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchData(from urlString: String, with completion: @escaping (Cocktails) -> Void) {
        AF.request(urlString).responseJSON { dataResponse in
            guard let statusCode = dataResponse.response?.statusCode else { return }
            print("STATUS CODE: \(statusCode)")
        }
        
        AF.request(urlString).validate().responseDecodable(of: Cocktails.self) { dataResponse in
            switch dataResponse.result {
            case .success(let cocktails):
                DispatchQueue.main.async {
                    completion(cocktails)
                }
            case .failure(let error):
                print("AF request has an error:\(error.localizedDescription)")
            }
        }
    }
    
    func fetchImage(from urlString: String) -> UIImage {
        guard let imagePlug = UIImage(named: "plug") else { return UIImage() }
        guard let url = URL(string: urlString) else { return UIImage() }
        guard let imageData = try? Data(contentsOf: url) else { return imagePlug }
        guard let image = UIImage(data: imageData) else { return imagePlug }
        
        return image
    }
    
    func fetchImage(from urlString: String, with complition: @escaping(UIImage) -> Void) {
        guard let url = URL(string: urlString) else { return }
        guard let imageData = try? Data(contentsOf: url) else { return }
        guard let image = UIImage(data: imageData) else { return }
        
        DispatchQueue.global().async {
            complition(image)
        }
    }
}
