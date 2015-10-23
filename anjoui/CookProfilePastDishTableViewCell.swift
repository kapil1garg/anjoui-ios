//
//  CookProfilePastDishTableViewCell.swift
//  anjoui
//
//  Created by Kevin Li on 10/22/15.
//  Copyright © 2015 anjoui. All rights reserved.
//

import UIKit

class CookProfilePastDishTableViewCell: UITableViewCell {

    @IBOutlet var cookProfilePastDishPic: UIImageView!
    
    @IBOutlet var cookProfilePastDishName: UILabel!
    
    @IBOutlet var cookProfilePastDishInfo: UILabel!
    
    @IBOutlet var cookProfilePastDishPrice: UILabel!
    
    @IBOutlet var cookProfilePastDishReserve: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setPastDishCell(cookProfilePastDishNameText: String, cookProfilePastDishInfoText: String, cookProfilePastDishPriceInt: Int, cookProfilePastDishPicText: String) {
        
        self.cookProfilePastDishName.text = cookProfilePastDishNameText
        self.cookProfilePastDishInfo.text = cookProfilePastDishInfoText
        self.cookProfilePastDishPrice.text = "$" + String(cookProfilePastDishPriceInt)
        self.cookProfilePastDishPic.image = UIImage(named: cookProfilePastDishPicText)
        
    }

}
