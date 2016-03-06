//
//  CookStatusPageCurrentDishTableViewCell.swift
//  anjoui
//
//  Created by Kevin Li on 10/28/15.
//  Copyright © 2015 anjoui. All rights reserved.
//

import UIKit

class CookStatusPageCurrentDishTableViewCell: UITableViewCell {

    @IBOutlet var CookStatusPageDishPic: UIImageView!
    @IBOutlet var CookStatusPageDishName: UILabel!
    @IBOutlet var CookStatusPageDishInfo: UILabel!
    @IBOutlet var CookStatusPageDishPrice: UILabel!
    @IBOutlet var CookStatusPageCancel: UIButton!
    
    func setCurrentDishCell(cookStatusPageCurrentDishNameText: String, cookStatusPageCurrentDishInfoText: String, cookStatusPageCurrentDishPriceInt: Int, cookStatusPageCurrentDishPicText: String) {
        
        self.CookStatusPageDishName.text = cookStatusPageCurrentDishNameText
        self.CookStatusPageDishInfo.text = cookStatusPageCurrentDishInfoText
        self.CookStatusPageDishPrice.text = "$" + String(cookStatusPageCurrentDishPriceInt)
        self.CookStatusPageDishPic.image = UIImage(named: cookStatusPageCurrentDishPicText)
        
    }
    
}
