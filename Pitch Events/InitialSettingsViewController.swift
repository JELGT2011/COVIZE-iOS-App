//
//  InitialFiltersViewController.swift
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
    @IBOutlet weak var Fundraising: UITextField!
    @IBOutlet weak var CapitalGoal: UITextField!
    
    var CompanyProfile: NSManagedObject?
    
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
        
        // Check to see if we are transitioning to the detailed event view
        if let eventPage = segue.destinationViewController as? EventTableViewController{
            //let's grap the managedContext again so that we can save the Company Profile
            let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
            let managedContext = appDelegate.managedObjectContext!
            
            CompanyProfile?.setValue(FemaleFounder.on, forKey: "femaleFounder")
            CompanyProfile?.setValue(EMFounder.on, forKey: "eMFounder")
            CompanyProfile?.setValue(PreferLocal.on, forKey: "preferLocal")
            CompanyProfile?.setValue(PreferIndustry.on, forKey: "preferIndustry")
            CompanyProfile?.setValue(Fundraising.text, forKey: "fundraising")
            CompanyProfile?.setValue(CapitalGoal.text, forKey: "capitalGoal")
            
            //pass on a Company Profile instance
            //eventPage.companyProfile = companyProfile
            
            //push companyProfile data to db
            var error: NSError?
            if !managedContext.save(&error) {
                println("Could not save \(error), \(error?.userInfo)")
            }
        }
    }
}