//
//  CookProfilePastDishViewController.swift
//  anjoui
//
//  Created by Kevin Li on 10/22/15.
//  Copyright © 2015 anjoui. All rights reserved.
//

import UIKit

class CookProfilePastDishViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var cookProfilePastDishTableView: UITableView!
    
    var arrayOfPastDishes: [EntreeModel] = [EntreeModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpPastDishes()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpPastDishes() {
        
        var pastDish1 = EntreeModel(name:"Past Dish 1", info: "Past Dish 1 info", price: 1, picName: "dish.jpg", profileName: "dish.jpg")
        var pastDish2 = EntreeModel(name:"Past Dish 2", info: "Past Dish 2 info", price: 2, picName: "dish4.jpg", profileName: "dish4.jpg")
        
        arrayOfPastDishes.append(pastDish1)
        arrayOfPastDishes.append(pastDish2)

        
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        
        return arrayOfPastDishes.count
        
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        
        let pastDishCell: CookProfilePastDishTableViewCell = tableView.dequeueReusableCellWithIdentifier("cookProfilePastDish") as! CookProfilePastDishTableViewCell
        
        let pastDish = arrayOfPastDishes[indexPath.row]
        
        pastDishCell.setPastDishCell(pastDish.name, cookProfilePastDishInfoText: pastDish.info, cookProfilePastDishPriceInt:pastDish.price, cookProfilePastDishPicText: pastDish.picName )
        
        
        return pastDishCell
        
        
        
    }
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
