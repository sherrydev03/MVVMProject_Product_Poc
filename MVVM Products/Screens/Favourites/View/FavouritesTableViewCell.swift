//
//  FavouritesTableViewCell.swift
//  MVVM Products
//
//  Created by  Macbook on 04/02/23.
//

import UIKit

class FavouritesTableViewCell: UITableViewCell {
	

	@IBOutlet weak var productImageView: UIImageView!
	@IBOutlet weak var productBackgroundView: UIView!
	@IBOutlet weak var productTitleLabel: UILabel!
	@IBOutlet weak var favButton: UIButton!
	@IBOutlet weak var priceLabel: UILabel!
	
    // closure button
	var buttonAddtoCart : (() -> Void)? = nil
	var buttonFav : ((String) -> Void)? = nil
	
	var product: Product? {
		didSet {
            // Property Observer
			productDetailConfiguration()
		}
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
		productBackgroundView.clipsToBounds = false
		productBackgroundView.layer.cornerRadius = 15
		productImageView.layer.cornerRadius = 10
		self.productBackgroundView.backgroundColor = .systemGray6
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		
		// Configure the view for the selected state
	}
	
	// MARK: - ui Button Actions
    @IBAction func favButton(_ sender: Any) {
        guard let id = product?.id else {return}
        buttonFav?(id)
    }
	
	// MARK: - func productDetailConfiguration
    func productDetailConfiguration() {
        guard let product else { return }
        productTitleLabel.text = product.title
        let price = product.price?.first?.value == nil ? Not_available : "$\(product.price!.first!.value!)"
        priceLabel.text = price
        favButton.setImage(product.isFavourite ? UIImage(systemName: "heart.fill") :UIImage(systemName: "heart") , for: .normal)
        productImageView.setImage(with: product.imageURL)
    }
}
