//
//  ProductM.swift
//  API-MVVM
//
//  Created by Murat Tunca on 5.08.2024.
//

import Foundation

// MARK: - Product
struct Product: Codable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: String
    let image: String
    let rating: Rating
}

// MARK: - Rating
struct Rating: Codable {
    let rate: Double
    let count: Int
}

struct EmptyResponse: Codable {}

