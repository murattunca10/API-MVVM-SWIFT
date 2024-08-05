//
//  ViewController.swift
//  API-MVVM
//
//  Created by Murat Tunca on 5.08.2024.
//

import UIKit
import SDWebImage

final class ProductV: UIViewController {
    
    private let viewModel = ProductVM()
    
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        setupTable()
        setupProducts()
        setupCategories()
    }

    private func setupNavigation() {
        navigationItem.title = "Products"
    }
    
    private func setupTable() {
        table.dataSource = self
        table.delegate = self
    }
    
    private func setupProducts() {
        viewModel.fetchProducts {
            DispatchQueue.main.async {
                self.table.reloadData()
            }
        }
    }
    
    private func setupCategories() {
        viewModel.fetchCategories {
            DispatchQueue.main.async {
                self.table.reloadData()
            }
        }
    }
    
    private func setupSortProductsByPrice(){
        viewModel.sortProductsByPrice()
        DispatchQueue.main.async {
            self.table.reloadData()
        }
    }
    
    private func showProductsByCategory(_ category: String) {
        viewModel.fetchProductsByCategory(category) {
            DispatchQueue.main.async {
                self.table.reloadData()
            }
        }
    }
    
    private func setupCategoriesActionSheet() {
        let actionSheet = UIAlertController(title: "Categories", message: nil, preferredStyle: .actionSheet)
        
        for index in 0..<viewModel.numberOfCategories() {
            let category = viewModel.categoryIndex(at: index)
            let action = UIAlertAction(title: category, style: .default) { _ in
                self.showProductsByCategory(category)
            }
            actionSheet.addAction(action)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let showAllAction = UIAlertAction(title: "All Products", style: .default) { [self] action in
            setupProducts()
        }
        actionSheet.addAction(cancelAction)
        actionSheet.addAction(showAllAction)
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    @IBAction func leftBarButtonAction(_ sender: Any) {
        setupSortProductsByPrice()
    }
    
    @IBAction func rightBarButtonAction(_ sender: Any) {
        setupCategoriesActionSheet()
    }
    
}

// MARK: - UITableViewDataSource

extension ProductV: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfProducts()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productsCell", for: indexPath) as! ProductTVC
        
        let product = viewModel.productIndex(at: indexPath.row)
        cell.titleLabel?.text = product.title
        cell.descriptionLabel.text = product.description
        cell.categoryLabel.text = product.category
        cell.ratingLabel.text = "★\(product.rating.rate)"
        cell.priceLabel.text = "$\(product.price)"
        
        if let imageUrl = URL(string: product.image) {
            cell.productImage.sd_setImage(with: imageUrl, completed: nil)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.deleteProduct(at: indexPath.row) { success, error in
                DispatchQueue.main.async { [self] in
                    if success {
                        table.deleteRows(at: [indexPath], with: .automatic)
                    } else if let error = error {
                        print("Failed to delete product: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
}

// MARK: - UITableViewDelegate

extension ProductV: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        table.deselectRow(at: indexPath, animated: true)
    }
}
