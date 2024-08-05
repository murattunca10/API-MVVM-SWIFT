//
//  ProductManager.swift
//  API-MVVM
//
//  Created by Murat Tunca on 5.08.2024.
//

import Foundation

class ProductManager {
    static let shared = ProductManager()
    
    func getProducts(completion: @escaping ([Product]?, Error?) -> ()) {
        let url = "https://fakestoreapi.com/products"
        NetworkManager.shared.request(type: [Product].self, url: url, method: .get, parameters: nil) { response in
            switch response {
            case .success(let items):
                completion(items, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    func getCategories(completion: @escaping ([String]?, Error?) -> ()) {
        let url = "https://fakestoreapi.com/products/categories"
        NetworkManager.shared.request(type: [String].self, url: url, method: .get, parameters: nil, headers: nil) { result in
            switch result {
            case .success(let items):
                completion(items, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    func getProductsByCategory(selectedCategory: String, completion: @escaping ([Product]?, Error?) -> ()) {
        let url = "https://fakestoreapi.com/products/category/\(selectedCategory)"
        NetworkManager.shared.request(type: [Product].self, url: url, method: .get, parameters: nil) { response in
            switch response {
            case .success(let items):
                completion(items, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    func deleteProductById(id: Int, completion: @escaping (Bool, Error?) -> ()) {
        let url = "https://fakestoreapi.com/products/\(id)"
        NetworkManager.shared.request(type: EmptyResponse.self, url: url, method: .delete, parameters: nil) { response in
            switch response {
            case .success:
                completion(true, nil)
            case .failure(let error):
                completion(false, error)
            }
        }
    }
}
