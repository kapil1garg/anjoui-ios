//
//  EntreeListTableViewCell.swift
//  anjoui
//
//  Copyright (c) 2015 anjoui. All rights reserved.
//

import UIKit

class EntreeListTableViewCell: UITableViewCell {
    
    // MARK: properties
    
    @IBOutlet var EntreeName: UILabel!
    @IBOutlet var EntreeInfo: UILabel!
    @IBOutlet var EntreePic: UIImageView!
    @IBOutlet var EntreePrice: UILabel!
    @IBOutlet var CookProfile: UIImageView!
    
    func setCell(EntreeNameText: String, EntreeInfoText: String, EntreePriceInt:Int, EntreePicText: String, CookProfileText: String){
        
        self.EntreeName.text = EntreeNameText
        self.EntreeInfo.text = EntreeInfoText
        self.EntreePrice.text = String(EntreePriceInt)
        self.EntreePic.image = UIImage(named: EntreePicText)
        self.CookProfile.image = UIImage(named: CookProfileText)
         
        
    }
}
