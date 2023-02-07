//
//  ProductViewModelTest.swift
//  MVVM Products
//
//  
//

import XCTest
@testable import MVVM_Products

final class ProductViewModelTest: XCTestCase {
	
	var productsViewModel: ProductViewModel!
	
	var randomIndex: Int!
	
    override func setUpWithError() throws {
		// Load Stub
		let data = loadStub(name: "Products", extsn: "json")
		
		// Create JSON Decoder
		let decoder = JSONDecoder()
		
		// Configure JSON Decoder
		decoder.dateDecodingStrategy = .secondsSince1970
		
		// Decode JSON
		let productList = try decoder.decode(ProductList.self, from: data)
		productsViewModel = ProductViewModel(products: productList.products)
		randomIndex = Int.random(in: 0..<productsViewModel.products.count)
		
    }

    override func tearDownWithError() throws {
		productsViewModel = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
	
	func test_initialization() {
		XCTAssertNotNil(productsViewModel, "The product view model should not be nil.")
	}
	
	func test_loading_all_products() {
		XCTAssertNotEqual(productsViewModel.products.count, 0,"The count should not be equal to zero as we have loaded the products")
	}
	
	func test_load_favorites_when_no_favorite() {
		XCTAssertEqual(productsViewModel.favoriteProducts().count, 0)
	}
	
	func test_add_favorite_product() {
		XCTAssertNotNil(productsViewModel.products[randomIndex],"It should be not nill as our index is less than list count")
		productsViewModel.products[randomIndex].isFavorite = false
		productsViewModel.updateFavorite(whereIdIs: productsViewModel.products[randomIndex].id)
		XCTAssertTrue(productsViewModel.products[randomIndex].isFavorite == true,"Product should be favorite")
	}
	
	func test_remove_favourite() {
		XCTAssertNotNil(productsViewModel.products[randomIndex],"It should be not nill as our index is less than list count")
		productsViewModel.products[randomIndex].isFavorite = true
		productsViewModel.updateFavorite(whereIdIs: productsViewModel.products[randomIndex].id)
		XCTAssertTrue(productsViewModel.products[randomIndex].isFavorite == false,"Product should be favorite")
	}
	
	func test_load_when_favourites_added(){
		let randomArray =  (0..<productsViewModel.products.count).map({_ in Int.random(in: 0..<productsViewModel.products.count)})
		
		let set = Set(randomArray)
		for index in set {
			productsViewModel.updateFavorite(whereIdIs: productsViewModel.products[index].id)
		}
		XCTAssertEqual(productsViewModel.favoriteProducts().count, set.count)
	}
}


extension XCTestCase {
	
	// MARK: - Helper Methods
	func loadStub(name: String, extsn: String) -> Data {
		let bundle = Bundle(for: type(of: self))
		
		// Ask Bundle for URL of Stub
		let url = bundle.url(forResource: name, withExtension: extsn)
		
		// Use URL to Create Data Object
		return try! Data(contentsOf: url!)
	}

}
