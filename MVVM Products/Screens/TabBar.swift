//
//  TabBar.swift
//  MVVM Products
//
//  Created by  Macbook on 03/02/23.

import UIKit

class TabBar: UITabBarController {
	
	var productsViewModel = ProductViewModel()
	var favoritesViewModel: FavouritesViewModel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		favoritesViewModel = FavouritesViewModel(productsViewModel: productsViewModel)
		setupChildViewControllers()
	}
	
        // MARK: - setupChildViewControllers
	func setupChildViewControllers() {
		guard let viewControllers = viewControllers else {return}
        // for loop for viewControllers
		for controller in viewControllers {
			guard let navigationController = controller as? UINavigationController else {return}
			guard let viewController = navigationController.viewControllers.first else {return}
			switch viewController {
				case let viewController as ProductListViewController:
					viewController.viewModel = productsViewModel
				case let viewController as FavouritesViewController:
					viewController.viewModel = favoritesViewModel
				default:
					break
			}
		}
	}
}



