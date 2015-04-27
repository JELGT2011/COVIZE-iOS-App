//
//  SettingsViewController.swift
//  Pitch Events
//
//  Created by Austin Delk on 4/22/15.
//  Copyright (c) 2015 Covize. All rights reserved.
//

import Foundation

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var UpgradeButton: UIButton!
    
    var ApplicationDelegate: AppDelegate?
    var companyProfile: CompanyProfile?
    var switchArr: [UISwitch]? = [UISwitch]()
    var pushSettings = [
        "New Events",
        "Favorited Events"
    ]
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pushSettings.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //don't really do anything here
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //create cell
        var cell = tableView.dequeueReusableCellWithIdentifier("pushSetting", forIndexPath: indexPath) as! UITableViewCell
        
        //format cell
        cell.textLabel?.text = pushSettings[indexPath.row]
        var enabledSwitch = switchArr?[indexPath.row]
        cell.accessoryView = enabledSwitch
        
        return cell
        
    }
    
    override func viewDidLoad() {
        ApplicationDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
        companyProfile = ApplicationDelegate?.companyProfile
        
        //set nave bar colors
        UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: false)
        navigationController?.navigationBar.barTintColor = HextoColor.uicolorFromHex(0x13342A)
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.whiteColor()
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.whiteColor()

        //Initialize the switches and set the values based on company profile
        var settingSwitch = UISwitch(frame: CGRectZero) as UISwitch
        settingSwitch.on = (companyProfile?.push_new_setting)!
        switchArr?.append(settingSwitch)
        
        settingSwitch = UISwitch(frame: CGRectZero) as UISwitch
        settingSwitch.on = (companyProfile?.push_favorite_setting)!
        switchArr?.append(settingSwitch)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //when we leave the screen save the changes
        //switchArr (local,industry,ethnic,femal)
        companyProfile?.push_new_setting = (switchArr?[0].on)!
        companyProfile?.push_favorite_setting = (switchArr?[1].on)!
    }
    
    //TO-DO implement in app market place
    @IBAction func UpgradeAction(sender: AnyObject) {
        
    }
}