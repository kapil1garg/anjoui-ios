//
//  SignupSelectProfileViewController.swift
//  anjoui
//
//  Copyright © 2015 anjoui. All rights reserved.
//

import UIKit

class SignupSelectProfileViewController: UIViewController {

    @IBAction func learnMoreTapped(sender: UIButton) {
        UIApplication.sharedApplication().openURL(NSURL(string: "http://www.anjoui.com/")!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
