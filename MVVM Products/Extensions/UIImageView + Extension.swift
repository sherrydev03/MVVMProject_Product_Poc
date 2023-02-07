//
//  UIImageView.swift
//  MVVM Products
//
//  Created by  Macbook on 03/02/23.
//
import UIKit
import Kingfisher

extension UIImageView {
    func setImage(with urlString: String?) {
        guard let url = URL.init(string: urlString ?? "") else {
            return
        }
        let resource = ImageResource(downloadURL: url, cacheKey: urlString)
        kf.indicatorType = .activity
        kf.setImage(with: resource)
    }
}

