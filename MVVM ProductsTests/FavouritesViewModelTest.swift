//
//  FavouritesViewModelTest.swift
//  MVVM ProductsTests
//

//

import XCTest
@testable import MVVM_Products

final class FavouritesViewModelTest: XCTestCase {

	var productsViewModel: ProductViewModel!
	var favouritesViewModel: FavouritesViewModel!
	var randomIndex: Int!
	
    override func setUpWithError() throws {
       
		let data = loadStub(name: "Products", extsn: "json")
		
		// Create JSON Decoder
		let decoder = JSONDecoder()
		
		// Configure JSON Decoder
		decoder.dateDecodingStrategy = .secondsSince1970
		
		// Decode JSON
		let productList = try decoder.decode(ProductList.self, from: data)
		productsViewModel = ProductViewModel(products: productList.products)
		randomIndex = Int.random(in: 0..<productsViewModel.products.count)
		
		favouritesViewModel = FavouritesViewModel(productsViewModel: productsViewModel)
		
    }
	
	func test_initialization() {
		XCTAssertNotNil(favouritesViewModel, "The faviourist view model should not be nil.")
	}
	
	func test_load_favorites_when_no_favorite() {
		XCTAssertEqual(productsViewModel.favoriteProducts().count, 0)
	}
		
	func test_add_and_remove_favourite_in_productsViewModel() {
		
		let id = productsViewModel.products[randomIndex].id
		XCTAssertNotNil(productsViewModel.products[randomIndex],"It should be not nill as our index is less than list count")
		productsViewModel.updateFavorite(whereIdIs: id)
		XCTAssertEqual(favouritesViewModel.favoriteProducts.count, 1,"There should be one element in favourite products as we added a favorite")
		XCTAssertEqual(favouritesViewModel.favoriteProducts[0].id, id)
		favouritesViewModel.updateFavorite(with: id)
		XCTAssertEqual(favouritesViewModel.favoriteProducts.count, 0,"There should be no data in favourite products as we removed favorite")
	}
	
	func test_load_when_favourites_added(){
		let randomArray =  (0..<productsViewModel.products.count).map({_ in Int.random(in: 0..<productsViewModel.products.count)})
		
		let set = Set(randomArray)
		for index in set {
			productsViewModel.updateFavorite(whereIdIs: productsViewModel.products[index].id)
		}
		XCTAssertEqual(favouritesViewModel.favoriteProducts.count, set.count)
	}

    override func tearDownWithError() throws {
		productsViewModel = nil
		favouritesViewModel = nil
		randomIndex = nil
    }
}
