//
//  CookStatusPageViewController.swift
//  anjoui
//
//  Created by Kevin Li on 10/28/15.
//  Copyright © 2015 anjoui. All rights reserved.
//

import UIKit

class CookStatusPageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var cookStatusPageCurrentDishTableView: UITableView!
    
    var arrayOfCurrentDishes: [EntreeModel] = [EntreeModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpCurrentDishes()
        
//        self.cookStatusPageCurrentDishTableView.registerClass(CookStatusPageCurrentDishTableViewCell.self, forCellReuseIdentifier: "cookStatusPageCurrentDishCell")

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
    
    // Generate the array for a past dish
    func setUpCurrentDishes() {
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
        
        for currentDish in dbEntrees {
            arrayOfCurrentDishes.append(EntreeModel(name: currentDish["dish_name"] as! String, info: currentDish["dish_description"] as! String, price: currentDish["dish_price"] as! Int, picName: "dish.jpg", profileName:"Profile_Photo.jpg"))
        }
    }
    
    
    // MARK: - Table view data source
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfCurrentDishes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let currentDishCell: CookStatusPageCurrentDishTableViewCell = self.cookStatusPageCurrentDishTableView.dequeueReusableCellWithIdentifier("cookStatusPageCurrentDishCell") as! CookStatusPageCurrentDishTableViewCell
        
        let dish = arrayOfCurrentDishes[indexPath.row]
        
        currentDishCell.setCurrentDishCell(dish.name, cookStatusPageCurrentDishInfoText: dish.info, cookStatusPageCurrentDishPriceInt:dish.price, cookStatusPageCurrentDishPicText: dish.picName )
        
        return currentDishCell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
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
