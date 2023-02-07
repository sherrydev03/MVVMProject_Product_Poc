//
//  Constant.swift
//  MVVM Products
//
//  Created by  Macbook on 03/02/23.
//

import UIKit

enum Constant {
    enum API {
        static let newProductURL = "https://run.mocky.io/"
    }
}

struct StoryBoards {
    
    static let Main = UIStoryboard(name: "Main", bundle: nil)

}

struct NotificationNames {
	
	static let favouriteUpdated = Notification.Name("favouriteUpdated")
}

