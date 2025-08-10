//
//  ProductTVC.swift
//  API-MVVM
//
//  Created by Murat Tunca on 5.08.2024.
//

import UIKit

class ProductTVC: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupConstraints()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setupConstraints() {
        [titleLabel, descriptionLabel, categoryLabel, ratingLabel, priceLabel, productImage].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        titleLabel.numberOfLines = 50
        descriptionLabel.numberOfLines = 50
        
        NSLayoutConstraint.activate([
            productImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            productImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            productImage.widthAnchor.constraint(equalToConstant: 100),
            productImage.heightAnchor.constraint(equalToConstant: 100),
            
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: productImage.leadingAnchor, constant: -16),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            descriptionLabel.trailingAnchor.constraint(equalTo: productImage.leadingAnchor, constant: -16),
            
            categoryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            categoryLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
            categoryLabel.trailingAnchor.constraint(equalTo: productImage.leadingAnchor, constant: -16),
            
            ratingLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            ratingLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 8),
            ratingLabel.trailingAnchor.constraint(equalTo: productImage.leadingAnchor, constant: -16),
            
            priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            priceLabel.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor, constant: 8),
            priceLabel.trailingAnchor.constraint(equalTo: productImage.leadingAnchor, constant: -16),
            priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
        
    }
}
