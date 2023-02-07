//
//  Product.swift
//   MVVM Products
//
//  Created by  Macbook on 03/02/23.
//



import Foundation

// MARK: - ProductList
struct ProductList: Codable {
    let products: [Product]?
}

// MARK: - Product
struct Product: Codable {
    let citrusID: String?
    let title, id: String?
    let imageURL: String?
    let price: [Price]?
    let brand: String?
    let badges: [String]?
    let ratingCount: Double?
    let messages: Messages?
    let isAddToCartEnable: Bool?
    let addToCartButtonText: String?
    let isInTrolley, isInWishlist: Bool?
 
    let isFindMeEnable: Bool?
    let saleUnitPrice: Double?
    let totalReviewCount: Int?
    let isDeliveryOnly, isDirectFromSupplier: Bool?

    // key added for favourite
	var isFavourite = false

    enum CodingKeys: String, CodingKey {
        case citrusID = "citrusId"
        case title, id, imageURL, price, brand, badges, ratingCount, messages, isAddToCartEnable, addToCartButtonText, isInTrolley, isInWishlist, isFindMeEnable, saleUnitPrice, totalReviewCount, isDeliveryOnly, isDirectFromSupplier
    }
}

// MARK: - Messages
struct Messages: Codable {
    let secondaryMessage: String?
    let promotionalMessage: String?
}


// MARK: - Price
struct Price: Codable {
    let message: String?
    let value: Double?
    let isOfferPrice: Bool?
}

