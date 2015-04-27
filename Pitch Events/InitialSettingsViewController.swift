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
    
    //TextField no editing
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool{
        return false
    }
    
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
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        
        companyProfile?.setValue(FemaleFounder.on, forKey: "female_founder")
        companyProfile?.setValue(EMFounder.on, forKey: "ethnic_founder")
        companyProfile?.setValue(PreferLocal.on, forKey: "prefer_local")
        companyProfile?.setValue(PreferIndustry.on, forKey: "prefer_industry")
        companyProfile?.setValue(true, forKey: "sort_event_start")
        companyProfile?.setValue(false, forKey: "sort_registration_deadline")
        //set the push notification settings
        companyProfile?.setValue(true, forKey: "push_new_setting")
        companyProfile?.setValue(true, forKey: "push_favorite_setting")

            
        //pass on a Company Profile instance
        appDelegate.companyProfile = (companyProfile as! CompanyProfile)
        appDelegate.refreshEvents = true //need to pull events from the db since this will be the first time running
        
        //push companyProfile data to local storage
        var error: NSError?
        if !managedContext.save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
        }
        
        //POST companyProfile data to the users table of the database
        var userDatabase = "http://covize-pitch-alerts.herokuapp.com/users" //base url for the users table
        let compProfile = companyProfile as! CompanyProfile // convert this here so that we don't have to every time we get a value
        
        //create a dictionary of the params because Alamofire will pass these for us as arguments pasted onto the end of the base url
        var params: [String: String] = [
            "personal_name": "\(compProfile.name!)",
            "email": "\(compProfile.email!)",
            "company_name": "\(compProfile.company_name!)",
            "industry": "\(compProfile.industry!)",
            "locale": "\(compProfile.locale!)"
        ]
        
        if FemaleFounder.on == true{
            params["female_founder"] = "true"
        }
        
        if EMFounder.on == true{
            params["ethnic_founder"] = "true"
        }
        
        if compProfile.capital_goal?.isEmpty == false{
            params["capial_goal"] = compProfile.capital_goal
        }
        
        if compProfile.fundraising?.isEmpty == false {
            params["fundraising_stage"] = compProfile.fundraising
        }
        
        //Alamofire POST request given base url and params dictionary
        request(.POST, userDatabase, parameters: params)
        
        
    }
    
    
    
    
    
}