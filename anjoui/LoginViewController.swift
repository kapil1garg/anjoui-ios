//
//  LoginViewController.swift
//  anjoui
//
//  Copyright (c) 2015 anjoui. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    var client = MSClient?()

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBAction func loginClick(sender: UIButton) {
        // Authenticate user
        var user_email:String = (txtEmail.text as String).stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        var user_pass:String = txtPassword.text as String
        
        if (user_email == "" || user_pass == "") {
            var alertView:UIAlertView = UIAlertView()
            alertView.title = "Please enter Email and Password"
            alertView.message = "Email and Password fields cannot be blank."
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
        } else if (!user_email.isValidEmail()){
            var alertView:UIAlertView = UIAlertView()
            alertView.title = "Invalid email"
            alertView.message = "Email must be in the format: example@anjoui.com"
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
        } else {
            let usertable = self.client!.tableWithName("users")
            
            let hashed_pass = ("Add some salt" + user_pass + "maybe some pepper").MD5()
            
            var users = []
            
            let userCheckPredicate = NSPredicate(format: "email == %@", user_email)
            usertable!.readWithPredicate(userCheckPredicate, completion: {
                (results, error) in
                if (error != nil)  {
                    NSLog(String(format: "%@", error.debugDescription))
                }
                users = results.items as! [Dictionary<String, String>]
                
                if (users.count != 0) {
                    let valid_pass = users[0]["password"] as! String
                    
                    if (hashed_pass == valid_pass) {
                        println("User is valid")
                        self.performSegueWithIdentifier("login_user", sender: nil)
                    } else {
                        var alertView:UIAlertView = UIAlertView()
                        alertView.title = "Sign in Failed"
                        alertView.message = "Incorrect Password"
                        alertView.delegate = self
                        alertView.addButtonWithTitle("OK")
                        alertView.show()
                    }
                } else {
                    var alertView:UIAlertView = UIAlertView()
                    alertView.title = "Sign in Failed"
                    alertView.message = "Email does not exist"
                    alertView.delegate = self
                    alertView.addButtonWithTitle("OK")
                    alertView.show()
                }
            })
        }
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
