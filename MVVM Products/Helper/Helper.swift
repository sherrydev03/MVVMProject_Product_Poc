//
//  ProductDetailsViewModel.swift
//  MVVM Products
//
//  Created by  Macbook on 03/02/23.
//

import Foundation
import UIKit

class Helper: NSObject {
    
    // MARK: - custom alert view
    
    class  func showAlert(msg: String, controller: UIViewController){
        let alertController = UIAlertController(title: "Alert", message: msg, preferredStyle: UIAlertController.Style.alert)
        let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(alertAction)
        controller.present(alertController, animated: true, completion: nil)
    }
    
    class func alertWithSingleAction(msg:String,target:UIViewController,clouser:@escaping() -> ()){
        
        let alertController = UIAlertController(title: "Alert", message: msg, preferredStyle: UIAlertController.Style.alert)
        let alertAction = UIAlertAction(title: "OK", style: .default) { (action) in
            clouser()
        }
        alertController.addAction(alertAction)
        target.present(alertController, animated: true, completion: nil)
        
    }
    
    class func showAlertWithoutTitle(for alert: String,target:UIViewController) {
        let alertController = UIAlertController(title: nil, message: alert, preferredStyle: UIAlertController.Style.alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertAction)
        target.present(alertController, animated: true, completion: nil)
    }
    
    class func convertBase64ToImage(imageString: String) -> UIImage? {
        let imageData = Data(base64Encoded: imageString, options: Data.Base64DecodingOptions.ignoreUnknownCharacters)!
        return UIImage(data: imageData)
    }
    
    class  func convertImageToBase64String (img: UIImage) -> String {
        return img.jpegData(compressionQuality: 1)?.base64EncodedString() ?? ""
    }
    
}
   
   
