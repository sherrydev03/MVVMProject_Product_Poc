 //
//  ProductListViewController.swift
//   MVVM Products
//
//  Created by  Macbook on 03/02/23.
//

import UIKit

class ProductListViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var productTableView: UITableView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Variables
    var viewModel : ProductViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    // MARK: -  toggle func for Favorite
    private func toggleFavorite(id: String) {
        viewModel.updateFavouriteForProducts(whereIdIs: id)
    }
    
    // MARK: - func goToDetail Product
    private func goToDetail(product: Product) {
        let controller = StoryBoards.Main.instantiateViewController(withIdentifier: "productDetailsViewController") as! productDetailsViewController
        controller.productDetailViewModel = ProductDetailsViewModel(product: product, productViewModel: viewModel)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    private func updateTable() {
        self.productTableView.reloadData()
    }
    
}

extension ProductListViewController {
    
    func configuration() {
        productTableView.register(UINib(nibName: "ProductCell", bundle: nil), forCellReuseIdentifier: "ProductCell")
        observeEvent()
        initViewModel()
    }

    func initViewModel() {
        viewModel.fetchProducts()
    }

    // MARK: - Data binding event observe karega - communication
    func observeEvent() {
        viewModel.eventHandler = { [weak self] event in
            guard let self else { return }
            switch event {
            case .loading:
                print("Product loading....")
            case .stopLoading:
                // Indicator hide
                self.activityIndicator.stopAnimating()
                print("Stop loading...")
            case .dataLoaded:
                print("Data loaded...")
                    self.productTableView.reloadData()
            case .error(let error):
                self.activityIndicator.stopAnimating()
                Helper.showAlert(msg: error ?? SMW , controller: self)
            case .dataUpdated:
				self.productTableView.reloadData()
            }
        }
    }
}


    // MARK: - UI Tableview Extension
extension ProductListViewController: UITableViewDataSource , UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

            return viewModel.products.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell") as? ProductCell else {
            return UITableViewCell()
        }
        let product = viewModel.products[indexPath.row]
        cell.product = product
        cell.buttonAddtoCart = {
            print(indexPath.row)
            Helper.showAlert(msg: TapToCart, controller: self)
        }
        cell.buttonFav = toggleFavorite(id:)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let product = viewModel.products[indexPath.row]
        goToDetail(product: product)
        
    }
    
}
