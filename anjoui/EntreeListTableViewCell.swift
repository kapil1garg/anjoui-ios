//
//  EntreeListTableViewCell.swift
//  anjoui
//
//  Copyright (c) 2015 anjoui. All rights reserved.
//

import UIKit

class EntreeListTableViewCell: UITableViewCell {
    
    // MARK: properties
    
    @IBOutlet weak var dishPrice: UILabel!
    @IBOutlet weak var dishPhoto: UIButton!
    @IBOutlet weak var distanceAndTime: UILabel!
    @IBOutlet weak var dishName: UIButton!
    @IBOutlet weak var cookProfile: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
