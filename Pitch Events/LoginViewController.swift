//
//  LoginViewController.swift
//  Pitch Events
//
//  Created by Austin Delk on 2/23/15.
//  Copyright (c) 2015 Covize. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // turn off nav bar from being displayed since this is a login page
        //navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @IBAction func checkCredentials(sender: AnyObject) {
        //To-Do check credentials from server

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
    }
    

}
