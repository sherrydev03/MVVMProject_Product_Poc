//
//  FavouritesViewController.swift
//  MVVM Products
//
//  Created by  Macbook on 03/02/23.
//

import UIKit

class FavouritesViewController: UIViewController {
	
    // Variables
	var viewModel : FavouritesViewModel!
	
    // IBOutlet
	@IBOutlet weak var FavouritesTable: UITableView!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		configuration()
		viewModel.updateData = updateTable
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		self.navigationController?.navigationBar.prefersLargeTitles = true
	}
    
    // Load tableview nib
	private func configuration() {
        FavouritesTable.register(UINib(nibName: "FavouritesTableViewCell", bundle: nil), forCellReuseIdentifier: "FavouritesTableViewCell")
	}
	
	private func toggleFavorite(id: String) {
		viewModel.updateFavourite(with: id)
	}
	
	private func goToDetail(product: Product) {
		let controller = StoryBoards.Main.instantiateViewController(withIdentifier: "productDetailsViewController") as! productDetailsViewController
		controller.productDetailViewModel = ProductDetailsViewModel(product: product, favouriteViewModel: viewModel)
		self.navigationController?.pushViewController(controller, animated: true)
	}
	
	private func updateTable() {
		self.FavouritesTable.reloadData()
	}
}

// MARK: - UI Tableview Extension
extension FavouritesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if viewModel.favouritesProducts.count == 0 {
            self.FavouritesTable.setEmptyMessage(No_Favourites)
        } else {
            self.FavouritesTable.restore()
        }
        return viewModel.favouritesProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavouritesTableViewCell") as? FavouritesTableViewCell else {
            return UITableViewCell()
        }
        let product = viewModel.favouritesProducts[indexPath.row]
        cell.product = product
        cell.buttonFav = toggleFavorite(id:)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = viewModel.favouritesProducts[indexPath.row]
        goToDetail(product: product)
    }
}
