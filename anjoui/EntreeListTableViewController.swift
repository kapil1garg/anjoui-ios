//// TABLE VIEW ONLY
////
////  EntreeListTableViewController.swift
////  anjoui
////
////  Copyright (c) 2015 anjoui. All rights reserved.
////
//
//import UIKit
//
//class EntreeListTableViewController: UITableViewController {
    // MARK: Properties
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Uncomment the following line to preserve selection between presentations
//        // self.clearsSelectionOnViewWillAppear = false
//
//        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
//    }
//    
//
//    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//
//    // MARK: - Table view data source
//
//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Potentially incomplete method implementation.
//        // Return the number of sections.
//        return 1
//    }
//
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete method implementation.
//        // Return the number of rows in the section.
//        return 100
//    }
//
//    
//    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let entrees = tableView.dequeueReusableCellWithIdentifier("EntreeListTableViewCell") as! EntreeListTableViewCell
//        
//        entrees.EntreePic.image = UIImage(named:"dish.jpg")
//        entrees.EntreeName.text = "Lotus Root with Edemame"
//        entrees.EntreePrice.text = "$10"
//        entrees.EntreeInfo.text = "0.9 mile|12:30pm-1:30pm"
//
//        return entrees
//    }
//
//
//    /*
//    // Override to support conditional editing of the table view.
//    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
//        // Return NO if you do not want the specified item to be editable.
//        return true
//    }
//    */
//
//    /*
//    // Override to support editing the table view.
//    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//        if editingStyle == .Delete {
//            // Delete the row from the data source
//            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
//        } else if editingStyle == .Insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }    
//    }
//    */
//
//    /*
//    // Override to support rearranging the table view.
//    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
//
//    }
//    */
//
//    /*
//    // Override to support conditional rearranging of the table view.
//    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
//        // Return NO if you do not want the item to be re-orderable.
//        return true
//    }
//    */
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        // Get the new view controller using [segue destinationViewController].
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}
//
// WITH SEARCH BAR
//
//
//  EntreeListTableViewController.swift
//  anjoui
//
//  Copyright (c) 2015 anjoui. All rights reserved.
//

import UIKit

class EntreeListTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // MARK: Properties
    
    @IBOutlet var tableView: UITableView!
    
    // Kevin:
    var arrayOfEntree: [EntreeModel] = [EntreeModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Kevin:
        self.setUpEntree()
        
        self.tableView.registerClass(EntreeListTableViewCell.self, forCellReuseIdentifier: "EntreeListTableViewCell")
        
        // To make sure the last cell can be displayed
        self.tableView.contentInset = UIEdgeInsetsMake(0,0,240,0)
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    
    //Calls this function when the tap is recognized.
    func DismissKeyboard(){
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Kevin: stupid way to generate the array for a dish
    func setUpEntree() {
        
        var entree1 = EntreeModel(name: "Lotus Root With Edemame", info: "0.9miles 12-2pm", price: 10, picName: "dish.jpg", profileName: "Profile_Photo.jpg")
        var entree2 = EntreeModel(name:"Lotus Root -2", info: "1.6 miles 12-2pm", price: 12, picName: "dish4.jpg", profileName: "Profile_Photo.jpg")
        var entree3 = EntreeModel(name:"This is testing", info: "hi there", price: 50, picName:"dine-food.png", profileName:"dish.jpg")
        
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
        
//        //        print(entrees.dishPic)
//        entrees.EntreePic?.image = UIImage(named:"dish.jpg")
//        entrees.EntreeName?.text = "Lotus Root with Edemame"
//        entrees.EntreePrice?.text = "$10"
//        entrees.EntreeInfo?.text = "0.9 mile|12:30pm-1:30pm"
//        
        return entrees
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    //    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    //        // #warning Potentially incomplete method implementation.
    //        // Return the number of sections.
    //        return 1
    //    }
    //
    //    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //        // #warning Incomplete method implementation.
    //        // Return the number of rows in the section.
    //        return 1
    //    }
    //
    //
    //    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    //        let entrees:EntreeListTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("EntreeListTableViewCell") as! EntreeListTableViewCell
    //
    ////        entrees.dishPic.image = UIImage(named:"dish.jpg")
    ////        entrees.dishName.text = "Lotus Root with Edemame"
    ////        entrees.dishPrice.text = "$10"
    ////        entrees.distanceAndTime.text = "0.9 mile|12:30pm-1:30pm"
    //
    //        return entrees
    //    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the specified item to be editable.
    return true
    }
    */
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
    // Delete the row from the data source
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    }
    */
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the item to be re-orderable.
    return true
    }
    */
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    }
    */
    
}
