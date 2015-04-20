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
    @IBOutlet weak var Industry: UILabel!
    @IBOutlet weak var CapitalGoal: UILabel!
    @IBOutlet weak var TableView: UITableView!
    var ApplicationDelegate: AppDelegate?
    var companyProfile: CompanyProfile?
    var switchArr: [UISwitch]? = [UISwitch]()
    
    let sorting = [
        ("Event Date"),
        ("Registration Deadline")
    ]
    
    let filters = [
        ("Local Events"),
        ("Industry Specific Events"),
        ("Ethnic/Minority Founder Targeted Events"),
        ("Female Founder Targeted Events")
    ]

    var sortSelectedCell:NSIndexPath = NSIndexPath()
    var sort_event_start: Bool?
    var sort_registration_deadline: Bool?
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0){
            return sorting.count
        } else{
            return filters.count
        }
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
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
        var cell = tableView.dequeueReusableCellWithIdentifier("filterSetting", forIndexPath: indexPath) as! UITableViewCell
        
        if (indexPath.section == 0){
            println("Row: \(sorting[indexPath.row]) \(sort_event_start) \(sort_registration_deadline)")
            var event_start = (sorting[indexPath.row] == "Event Date" && sort_event_start == true)
            var reg_deadline = (sorting[indexPath.row] == "Registration Deadline" && sort_registration_deadline == true)
            
            //check which cell we are putting in by the name, then check the bool set by company profile. We know that only one or the other is true
            if(event_start || reg_deadline){
                sortSelectedCell = indexPath
                cell.accessoryType = .Checkmark
            } else {
                cell.accessoryType = .None
            }
            
            //Now actually set the text to be shown in the cell
            cell.textLabel?.text = sorting[indexPath.row]
            
        //Now we are moving on the the other section of filters
        } else{
            //Set the cell's text
            cell.textLabel?.text = filters[indexPath.row]
            
            //take the switches from the array and set them as the acessory view of each row
            var enabledSwitch = switchArr?[indexPath.row]
            cell.accessoryView = enabledSwitch
            
        }
        
        //Not a big fan of it highlighting the cells upon selection, so let's turn that off
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        return cell
    }

    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (section == 0){
            return "Sort Events By:"
        } else{
            return "Filter Events Based On:"
        }
    }
    
    //On save we need to update the CompanyProfile attributes and also tell the eventTableView that it needs to fetch new events
    @IBAction func saveFilters(sender: AnyObject) {
        //switchArr (local,industry,ethnic,femal)
        companyProfile?.prefer_local = (switchArr?[0].on)!
        companyProfile?.prefer_industry = (switchArr?[1].on)!
        companyProfile?.ethnic_founder = (switchArr?[2].on)!
        companyProfile?.female_founder = (switchArr?[3].on)!
        
        //set the sorting flags
        var sortSelected = self.TableView.cellForRowAtIndexPath(sortSelectedCell)
        if(sortSelected?.textLabel?.text == "Event Date"){
            companyProfile?.sort_event_start = true
            companyProfile?.sort_registration_deadline = false
        } else{
            companyProfile?.sort_event_start = false
            companyProfile?.sort_registration_deadline = true
        }
        
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
        
        //set the Company Profile data
        self.navigationItem.title = companyProfile?.company_name
        self.Industry.text = "Industry: \(companyProfile?.industry)"
        self.CapitalGoal.text = "Capital Goal: \(companyProfile?.capital_goal)"
        
        //set the sorting settings from the company profile
        self.sort_event_start = companyProfile?.sort_event_start
        self.sort_registration_deadline = companyProfile?.sort_registration_deadline
        
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
