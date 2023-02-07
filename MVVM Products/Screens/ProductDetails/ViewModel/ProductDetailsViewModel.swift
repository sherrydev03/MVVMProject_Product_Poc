//
//  ProductDetailsViewModel.swift
//  MVVM Products
//
//  Created by  Macbook on 04/02/23.
//

import Foundation

final class ProductDetailsViewModel {
    
    // Declare variable
    private var productViewModel: ProductViewModel!
    private var favouriteViewModel: FavouritesViewModel!
    var product: Product
    private var detailFor = DetailFor.none
    
    var updateData: (() -> Void)? = nil
    
    private init(product: Product) {
        self.product = product
    }
    
    // MARK: - Convenience initializers for Product list
    convenience init(product:Product,productViewModel:ProductViewModel) {
        self.init(product: product)
        self.productViewModel = productViewModel
        detailFor = .allProduct
    }
    
    // MARK: - Convenience initializers for Fav list
    convenience init(product:Product,favouriteViewModel:FavouritesViewModel) {
        self.init(product: product)
        self.favouriteViewModel = favouriteViewModel
        detailFor = .favorite
    }
        // MARK: - func updateFavourite with cases
    func updateFavourite (withId id: String) {
        
        switch detailFor {
        case .favorite:
            product.isFavourite = !product.isFavourite
            favouriteViewModel.updateFavourite(with: id)
            updateData?()
        case .allProduct:
            product.isFavourite = !product.isFavourite
            productViewModel.updateFavouriteForProducts(whereIdIs: id)
            updateData?()
        case .none:
            break
        }
    }
    
    private enum DetailFor {
        case favorite
        case allProduct
        case none
    }
}

