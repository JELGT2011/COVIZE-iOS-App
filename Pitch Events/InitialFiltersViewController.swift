//
//  InitialFiltersViewController.swift
//  Pitch Events
//
//  Created by Austin Delk on 4/3/15.
//  Copyright (c) 2015 Covize. All rights reserved.
//

import Foundation

class InitialFiltersViewController: UIViewController{
    
    //Called as the first method once this view has been set to be displayed
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // Check to see if we are transitioning to the detailed event view
        if let eventPage = segue.destinationViewController as? EventTableViewController{
            //pass on a Company Profile instance
            
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
}