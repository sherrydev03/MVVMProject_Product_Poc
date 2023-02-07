//
//  productDetailsViewController.swift
//  MVVM Products
//
//  Created by  Macbook on 04/02/23.
//

import UIKit

class productDetailsViewController: UIViewController {
    
    // Variables
    var productDetailViewModel : ProductDetailsViewModel?
    
    // IBOutlet
    @IBOutlet weak var lblBrand: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var ratingView: StarRatingView!
    @IBOutlet weak var favouriteButton: UIButton!
    @IBOutlet weak var ImgProduct: UIImageView!
    @IBOutlet weak var lblPrice: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.clipsToBounds = false
        mainView.layer.cornerRadius = 15
        mainView.layer.cornerRadius = 10
        self.mainView.backgroundColor = .systemGray6
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.title = Product_Details
        productDetailViewModel?.updateData = populateData
        
        //Fetch data method
        populateData()
        
    }
    
    // MARK: - func populateData
    private func populateData() {
        
        guard let product = productDetailViewModel?.product else {return}
        lblName.text = product.title
        lblBrand.text = product.brand
        let price = product.price?.first?.value == nil ? Not_available : "$\(product.price!.first!.value!)"
        lblPrice.text = price
        favouriteButton.setImage(product.isFavourite ? UIImage(systemName: "heart.fill") :UIImage(systemName: "heart"), for: .normal)
        ratingView.rating = Float(product.ratingCount ?? 0.0)
        ImgProduct.setImage(with: product.imageURL)
        
    }
    // MARK: - func toggleFavorite
    @IBAction func toggleFavorite(_ sender: UIButton) {
        guard let id = productDetailViewModel?.product.id else {return}
        productDetailViewModel?.updateFavourite(withId: id)
    }
    
}
