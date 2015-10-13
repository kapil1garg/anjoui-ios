//
//  EntreeListTableViewController.swift
//  anjoui
//
//  Copyright © 2015 anjoui. All rights reserved.
//
//

import UIKit

class EntreeListTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // MARK: Properties
    
    @IBOutlet var tableView: UITableView!
    
    var arrayOfEntree: [EntreeModel] = [EntreeModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpEntree()
        
        self.tableView.registerClass(EntreeListTableViewCell.self, forCellReuseIdentifier: "EntreeListTableViewCell")
        
        // auto sizing for cells on different size screens
        self.tableView.estimatedRowHeight = 240.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    
    //Calls this function when the tap is recognized.
    func DismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Generate the array for a dish
    func setUpEntree() {
        let entree1 = EntreeModel(name: "Lotus Root With Edemame", info: "0.9miles | 12-2pm", price: 10, picName: "dish.jpg", profileName: "Profile_Photo.jpg")
        let entree2 = EntreeModel(name:"Lotus Root -2", info: "1.6 miles | 12-2pm", price: 12, picName: "dish4.jpg", profileName: "Profile_Photo.jpg")
        let entree3 = EntreeModel(name:"This is testing", info: "hi there", price: 50, picName:"dine-food.png", profileName:"dish.jpg")
        
        arrayOfEntree.append(entree1)
        arrayOfEntree.append(entree2)
        arrayOfEntree.append(entree3)
    }
    
    
    // MARK: - Table view data source
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfEntree.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let entrees:EntreeListTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("EntreeCell") as! EntreeListTableViewCell
        let dish = arrayOfEntree[indexPath.row]
        
        entrees.setCell(dish.name, EntreeInfoText: dish.info, EntreePriceInt: dish.price, EntreePicText: dish.picName, CookProfileText: dish.profileName)
        
        return entrees
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    }
    */
}
