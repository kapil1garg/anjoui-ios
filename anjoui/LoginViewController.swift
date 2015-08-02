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
