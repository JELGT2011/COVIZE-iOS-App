//
//  SupportViewController.swift
//  Pitch Events
//
//  Created by Cameron Jones on 4/21/15.
//  Copyright (c) 2015 Covize. All rights reserved.
//

import Foundation

class SupportViewController: UIViewController{
    
    override func viewDidLoad() {
        //set the navbar color
        UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: false)
        navigationController?.navigationBar.barTintColor = HextoColor.uicolorFromHex(0x13342A)
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.whiteColor()

    }
    //open link to the http://www.covize.com/take-action/
    @IBAction func FeedbackReportAction(sender: AnyObject) {
        var url = "http://www.covize.com/take-action/"
        if let urlLink = NSURL(string: (url)){
            UIApplication.sharedApplication().openURL(urlLink)
        }
    }
    
    //open link to http://www.covize.com/new-page-4/
    @IBAction func NewsAdviceAction(sender: AnyObject) {
        var url = "http://www.covize.com/new-page-4/"
        if let urlLink = NSURL(string: (url)){
            UIApplication.sharedApplication().openURL(urlLink)
        }
    }
    
}