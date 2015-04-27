//
//  SupportViewController.swift
//  Pitch Events
//
//  Created by Cameron Jones on 4/21/15.
//  Copyright (c) 2015 Covize. All rights reserved.
//

import Foundation

class ContactViewController: UIViewController{
    
    override func viewDidLoad() {
        //set the navbar color
        UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: false)
        navigationController?.navigationBar.barTintColor = HextoColor.uicolorFromHex(0x13342A)
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.whiteColor()
        
    }
    
    //link to http://www.covize.com/partners/
    @IBAction func SuggestEventAction(sender: AnyObject) {
        var url = "http://www.covize.com/partners/"
        if let urlLink = NSURL(string: (url)){
            UIApplication.sharedApplication().openURL(urlLink)
        }
    }
    
    //link to http://www.covize.com/what-we-do/
    @IBAction func AboutCovizeAction(sender: AnyObject) {
        var url = "http://www.covize.com/what-we-do/"
        if let urlLink = NSURL(string: (url)){
            UIApplication.sharedApplication().openURL(urlLink)
        }
    }
    
}