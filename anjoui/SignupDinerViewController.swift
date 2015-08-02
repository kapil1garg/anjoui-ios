//
//  SignupDinerViewController.swift
//  anjoui
//
//  Copyright (c) 2015 anjoui. All rights reserved.
//

import UIKit

class SignupDinerViewController: UIViewController {

    var client = MSClient?()
    
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtPhoneNumber: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    
    @IBAction func dinerSignup(sender: UIButton) {
        performSegueWithIdentifier("diner_signup", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.client = MSClient(
            applicationURLString:"https://anjoui-test-ale.azure-mobile.net/",
            applicationKey:"EVLaGLPcRrWygXxmjjpYFviRlsfUgE86"
        )
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
