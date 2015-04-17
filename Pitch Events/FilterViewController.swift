//
//  FilterViewController.swift
//  Pitch Events
//
//  Created by Cameron Jones on 2/15/15.
//  Copyright (c) 2015 Covize. All rights reserved.
//

import UIKit
import CoreData

class FilterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var filterTableView: UITableView!
    var ApplicationDelegate: AppDelegate?
    var companyProfile: CompanyProfile?
    var switchArr: [UISwitch]? = [UISwitch]()
    
    let sorting = [
        ("Event Date"),
        ("Registration Deadline")
    ]
    
    let filters = [
        ("Local Events Only"),
        ("Industry Specific Events"),
        ("Ethnic/Minority Founder"),
        ("Female Founder")
    ]
    
    let recommended = [
        ("Use Company Profile to set Filters")
    ]
    
    var sortSelectedCell:NSIndexPath = NSIndexPath()
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0){
            return sorting.count
        } else if (section == 1){
            return filters.count
        } else {
            return recommended.count
        }
    }
    
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        
        //If the selected row is in the "Sorted By" section and the selected row isn't the one that is already checked, then we're going to decheck the old cell and check the new one
        if ((indexPath.section == 0) && (sortSelectedCell.row != indexPath.row)){
            let oldSelectedCell:UITableViewCell = tableView.cellForRowAtIndexPath(sortSelectedCell)!
            let newSelectedCell:UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
            
            oldSelectedCell.accessoryType = .None
            newSelectedCell.accessoryType = .Checkmark
            
            //set the selected cell var to the indexPath of the new cell
            sortSelectedCell = indexPath
        }

    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("filterSetting", forIndexPath: indexPath) as UITableViewCell
        
        if (indexPath.section == 0){
            
            //This sets the first row in the "Sort By" Section to be checked by default
            if(indexPath.row == 0) {
                //Set the selected cell to the first cell
                sortSelectedCell = indexPath
                
                //Set its accessory type to the checkmark
                cell.accessoryType = .Checkmark
            } else {
                //For every other sorting option set them to no checkmark
                cell.accessoryType = .None
            }
            
            //Now actually set the text to be shown in the cell
            cell.textLabel?.text = sorting[indexPath.row]
            
        //Now we are moving on the the other section of filters
        } else if ( indexPath.section == 1){
            //Set the cell's text
            cell.textLabel?.text = filters[indexPath.row]
            
            //take the switches from the array and set them as the acessory view of each row
            var enabledSwitch = switchArr?[indexPath.row]
            cell.accessoryView = enabledSwitch
            
        } else {
            //Set the cell's text
            cell.textLabel?.text = recommended[indexPath.row]
            
            //create a toggle switch, default its state to false, add it to the cell's accessory views
            var enabledSwitch = UISwitch(frame: CGRectZero) as UISwitch
            enabledSwitch.on = false
            cell.accessoryView = enabledSwitch
        }
        
        //Not a big fan of it highlighting the cells upon selection, so let's turn that off
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        return cell
    }

    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (section == 0){
            return "Sort By:"
        } else if (section == 1){
            return "Filter By:"
        } else {
            return "Default"
        }
    }
    
    //On save we need to update the CompanyProfile attributes and also tell the eventTableView that it needs to fetch new events
    @IBAction func saveFilters(sender: AnyObject) {
        //switchArr (local,industry,ethnic,femal)
        companyProfile?.prefer_local = (switchArr?[0].on)!
        companyProfile?.prefer_industry = (switchArr?[1].on)!
        companyProfile?.ethnic_founder = (switchArr?[2].on)!
        companyProfile?.female_founder = (switchArr?[3].on)!
        
        //We have most likely changed the filters, let's pull new events
        ApplicationDelegate?.refreshEvents = true
        
        self.performSegueWithIdentifier("saveFiltersSegue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ApplicationDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
        companyProfile = ApplicationDelegate?.companyProfile
        
        
        //Initialize the toggles and set their values based on the company profile (local,industry,ethnic,female)
        var flagSwitch = UISwitch(frame: CGRectZero) as UISwitch
        flagSwitch.on = (companyProfile?.prefer_local)!
        switchArr?.append(flagSwitch)
        
        flagSwitch = UISwitch(frame:CGRectZero) as UISwitch
        flagSwitch.on = (companyProfile?.prefer_industry)!
        switchArr?.append(flagSwitch)
        
        flagSwitch = UISwitch(frame:CGRectZero) as UISwitch
        flagSwitch.on = (companyProfile?.ethnic_founder)!
        switchArr?.append(flagSwitch)
        
        flagSwitch = UISwitch(frame:CGRectZero) as UISwitch
        flagSwitch.on = (companyProfile?.female_founder)!
        switchArr?.append(flagSwitch)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    

}
