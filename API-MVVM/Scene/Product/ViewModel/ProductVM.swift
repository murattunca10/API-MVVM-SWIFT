//
//  ProductVM.swift
//  API-MVVM
//
//  Created by Murat Tunca on 5.08.2024.
//

import Foundation

class ProductVM {
    var products = [Product]()
    var categories = [String]()
    
    private var isAscending = true
    
    func fetchProducts(completion: @escaping () -> Void) {
        ProductManager.shared.getProducts { data, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else if let data = data {
                self.products = data
                print("Products: ", self.products)
                completion()
            }
        }
    }
    
    func fetchCategories(completion: @escaping () -> Void) {
        ProductManager.shared.getCategories { data, error in
            if let error = error {
                print("Error fetching categories: \(error.localizedDescription)")
            } else if let data = data {
                self.categories = data
                print("Categories: ", self.categories)
                completion()
            }
        }
    }
    
    func fetchProductsByCategory(_ category: String, completion: @escaping () -> Void) {
        ProductManager.shared.getProductsByCategory(selectedCategory: category) { data, error in
            if let error = error {
                print("Error fetching products for category \(category): \(error.localizedDescription)")
            } else if let data = data {
                self.products = data
                print("Filtered Products: ", self.products)
                completion()
            }
        }
    }
    
    func deleteProduct(at index: Int, completion: @escaping (Bool, Error?) -> Void) {
        let productId = products[index].id
        ProductManager.shared.deleteProductById(id: productId) { success, error in
            if success {
                self.products.remove(at: index)
                completion(true, nil)
                print("Deletion successful")
            } else {
                completion(false, error)
                print("An error occurred during deletion: \(String(describing: error?.localizedDescription))")
            }
        }
    }

    func sortProductsByPrice() {
        products.sort { isAscending ? $0.price < $1.price : $0.price > $1.price }
        isAscending.toggle()
    }
    
    func numberOfProducts() -> Int {
        return products.count
    }
    
    func productIndex(at index: Int) -> Product {
        return products[index]
    }
    
    func numberOfCategories() -> Int {
        return categories.count
    }
    
    func categoryIndex(at index: Int) -> String {
        return categories[index]
    }
}
