//
//  SplashViewController.swift
//  Pitch Events
//
//  Created by Austin Delk on 2/23/15.
//  Copyright (c) 2015 Covize. All rights reserved.
//

import UIKit
import CoreData

class SplashViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Here we are going to display a nice splash screen BUT also check to see if a company profile has already been created by the user
        //If there is a company profile then we will head straight to the event table view, if NOT then we will direct the user to create one
        
        let timer = NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: "checkFirstUse", userInfo: nil, repeats: false) //Display splash screen for 8sec do segue logic
        
    }
    
    func checkFirstUse(){
        //Grab the app delegat and the managed context
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        
        //Build a fetch request that will grab all entities of description CompanyProfile
        let fetchRequest = NSFetchRequest(entityName:"CompanyProfile")
        
        //Check to see if we got any
        var error: NSError?
        
        let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as [NSManagedObject]?
        
        if (fetchedResults?.count > 0){
            println("Count:  \(fetchedResults?.count)\n" + "Company Profile: \(fetchedResults?[0])")
            //We should segue to the Event Table View
            self.performSegueWithIdentifier("EventTableViewSegue", sender: self)
        } else {
            //We should segue to the General Info View to begin creation of a company profile
            self.performSegueWithIdentifier("GeneralInfoViewSegue", sender: self)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
    }
    

}
