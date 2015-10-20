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
    
    var arrayOfEntrees: [EntreeModel] = [EntreeModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpEntree()
        
        self.tableView.registerClass(EntreeListTableViewCell.self, forCellReuseIdentifier: "EntreeListTableViewCell")
        
        // Auto sizing for cells on different size screens
        self.tableView.estimatedRowHeight = 240.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        // Make sure last cell displays properly, 800 being the view controller inferface height in main story board
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 800 - UIScreen.mainScreen().bounds.height, 0)

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
    
    func pullEntrees() -> [Dictionary<String, AnyObject>] {
        // create connection URL
        let url: NSURL = NSURL(string: "http://ec2-52-23-188-123.compute-1.amazonaws.com/anjoui/get_dishes.php")!
        let request:NSMutableURLRequest = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        var response: NSURLResponse?
        do {
            let urlData: NSData? = try NSURLConnection.sendSynchronousRequest(request, returningResponse: &response)
            
            if ( urlData != nil ) {
                let res = response as! NSHTTPURLResponse!;
                NSLog("Response code: %ld", res.statusCode);
                
                if (res.statusCode == 200) {
                    do {
                        let jsonData:NSArray = try NSJSONSerialization.JSONObjectWithData(urlData!, options: NSJSONReadingOptions.MutableContainers) as! NSArray
                        
                        var mealArray = [Dictionary<String, AnyObject>]()
                        for meal in jsonData {
                            mealArray.append(meal as! Dictionary<String, AnyObject>)
                        }
                        return mealArray
                    } catch let error as NSError {
                        print(error)
                        return []
                    }
                }
            } else {
                return []
            }
        } catch let error as NSError {
            print(error)
            return []
        }
        return []
    }
    
    // Generate the array for a dish
    func setUpEntree() {
        let dbEntrees = pullEntrees()
        print(dbEntrees)
        
        if (dbEntrees.count == 0) {
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Error"
            alertView.message = "Could not connect to database. Please try again later."
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
        } else {
            
        }
        
        for entree in dbEntrees {
            arrayOfEntrees.append(EntreeModel(name: entree["dish_name"] as! String, info: entree["dish_description"] as! String,
                price: entree["dish_price"] as! Int, picName: "dish.jpg", profileName:"Profile_Photo.jpg"))
        }
    }
    
    
    // MARK: - Table view data source
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfEntrees.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let entrees:EntreeListTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("EntreeCell") as! EntreeListTableViewCell
        let dish = arrayOfEntrees[indexPath.row]
        
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
