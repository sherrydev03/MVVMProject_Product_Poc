//
//  FavouritesViewModel.swift
//  MVVM Products
//
//  Created by  Macbook on 04/02/23.
//

import Foundation

final class FavouritesViewModel {
    
	// declare variable
	private var productsViewModel: ProductViewModel
	var favouritesProducts: [Product] = []
	var updateData: (() -> Void)? // Data Binding Closure
	
	init(productsViewModel: ProductViewModel) {
		self.productsViewModel = productsViewModel
		NotificationCenter.default.addObserver(self, selector: #selector(loadFavoriteProducts), name: NotificationNames.favouriteUpdated, object: nil)
	}
	
    // MARK: - func load favourites
	@objc func loadFavoriteProducts() {
		self.favouritesProducts = productsViewModel.favoriteProducts()
		self.updateData?()
	}
	
    // MARK: - func updatefavourite Products with id
	func updateFavourite(with id: String) {
		productsViewModel.updateFavouriteForProducts(whereIdIs: id)
	}
}
