//
//  InitialSettingsViewController.swift
//  Pitch Events
//
//  Created by Cameron Jones on 4/3/15.
//  Copyright (c) 2015 Covize. All rights reserved.
//

import Foundation
import CoreData

class InitialSettingsViewController: UIViewController{
    
    @IBOutlet weak var FemaleFounder: UISwitch!
    @IBOutlet weak var EMFounder: UISwitch!
    @IBOutlet weak var PreferLocal: UISwitch!
    @IBOutlet weak var PreferIndustry: UISwitch!
    
    var companyProfile: NSManagedObject?
    
    //Called as the first method once this view has been set to be displayed
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FemaleFounder.on = false
        EMFounder.on = false
        PreferLocal.on = false
        PreferIndustry.on = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        //let's grap the managedContext again so that we can save the Company Profile
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        
        companyProfile?.setValue(FemaleFounder.on, forKey: "female_founder")
        companyProfile?.setValue(EMFounder.on, forKey: "ethnic_founder")
        companyProfile?.setValue(PreferLocal.on, forKey: "prefer_local")
        companyProfile?.setValue(PreferIndustry.on, forKey: "prefer_industry")

            
        //pass on a Company Profile instance
        appDelegate.companyProfile = (companyProfile as CompanyProfile)
        appDelegate.refreshEvents = true //need to pull events from the db since this will be the first time running
        
        //push companyProfile data to local storage
        var error: NSError?
        if !managedContext.save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
        }
    }
}