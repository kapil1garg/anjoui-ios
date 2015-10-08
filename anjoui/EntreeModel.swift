//
//  EntreeModel.swift
//  anjoui
//
//  Created by Kevin Li on 10/7/15.
//  Copyright © 2015 anjoui. All rights reserved.
//

import Foundation
class EntreeModel {
    var name = "name"
    var info = "info"
    var price = 0
    var picName = "blank"
    var profileName = "blank"
    
    init(name: String, info: String, price: Int, picName: String, profileName: String){
        
        self.name = name
        self.info = info
        self.price = price
        self.picName = picName
        self.profileName = profileName
        
    }
}