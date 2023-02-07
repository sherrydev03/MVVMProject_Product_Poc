//
//  Product.swift
//   MVVM Products
//
//  Created by  Macbook on 03/02/23.
//



import Foundation

// MARK: - ProductList
struct ProductList: Decodable {
    let products: [Product]?
	enum CodingKeys: String, CodingKey {
		case products
	}
}

// MARK: - Product
struct Product: Decodable {
    let citrusId: String?
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
        case citrusId = "citrusId"
        case title, id, imageURL, price, brand, badges, ratingCount, messages, isAddToCartEnable, addToCartButtonText, isInTrolley, isInWishlist, isFindMeEnable, saleUnitPrice, totalReviewCount, isDeliveryOnly, isDirectFromSupplier
    }
}

// MARK: - Messages
struct Messages: Decodable {
    let secondaryMessage: String?
    let promotionalMessage: String?
	enum CodingKeys: String, CodingKey {
		case secondaryMessage
		case promotionalMessage
	}
}


// MARK: - Price
struct Price: Decodable {
    let message: String?
    let value: Double?
    let isOfferPrice: Bool?
	enum CodingKeys: String, CodingKey {
		case message
		case value
		case isOfferPrice
	}
}

