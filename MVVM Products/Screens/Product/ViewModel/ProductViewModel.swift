//
//  ProductViewModel.swift
//   MVVM Products
//
//  Created by  Macbook on 03/02/23.
//

import Foundation

final class ProductViewModel {
    
    // Variable
    var products: [Product] = []
    
    var eventHandler: ((_ event: Event) -> Void)? // Data Binding Closure
    
    init(products: [Product] = [Product]()) {
        self.products = products
    }
    
    // MARK: - fetchProducts
    func fetchProducts() {
        if Reachability.isConnectedToNetwork() {
            self.eventHandler?(.loading)
            APIManager.shared.request(
                modelType: ProductList.self,
                type: ProductEndPoint.newProducts) { response in
                    DispatchQueue.main.async {
                        self.eventHandler?(.stopLoading)
                    }
                    switch response {
                    case .success(let productList):
                        guard let uwProducts = productList.products else{
                            DispatchQueue.main.async {
                                self.eventHandler?(.error(No_Products))
                            }
                            return
                        }
                        self.products = uwProducts
                        DispatchQueue.main.async {
                            self.eventHandler?(.dataLoaded)
                        }
                    case .failure(let error):
                        DispatchQueue.main.async {
                            self.eventHandler?(.error(error.localizedDescription))
                        }
                    }
                }
        } else {
            self.eventHandler?(.error(No_Netowrk))
        }
    }

    // favorite Products filter
    func favoriteProducts() -> [Product] {
        let products =  products.filter { product in
            product.isFavourite
        }
        return products
    }
    
        // MARK: - updateFavourite For Products with id
    func updateFavouriteForProducts(whereIdIs id: String) {
        guard let indexOfFavourite = products.firstIndex(where: {$0.id == id}) else{return}
        products[indexOfFavourite].isFavourite = !products[indexOfFavourite].isFavourite
        self.eventHandler?(.dataUpdated)
        NotificationCenter.default.post(name: NotificationNames.favouriteUpdated, object: nil)
    }
}

extension ProductViewModel {
    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(String?)
        case dataUpdated
	}
}
