//
//  FilterViewController.swift
//  Pitch Events
//
//  Created by Cameron Jones on 2/15/15.
//  Copyright (c) 2015 Covize. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let sorting = [
        ("Date: Most Recent"),
        ("Proximity")
    ]
    
    let filters = [
        ("Industry Specific"),
        ("Minority Executive"),
        ("Female Executive")
    ]
    
    let recommended = [
        ("Use Recommended Filters")
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
            
            cell.textLabel?.text = sorting[indexPath.row]
            
        } else if ( indexPath.section == 1){
            cell.textLabel?.text = filters[indexPath.row]
            
            var enabledSwitch = UISwitch(frame: CGRectZero) as UISwitch
            enabledSwitch.on = false
            cell.accessoryView = enabledSwitch

            
        } else {
            cell.textLabel?.text = recommended[indexPath.row]
            
            var enabledSwitch = UISwitch(frame: CGRectZero) as UISwitch
            enabledSwitch.on = false
            cell.accessoryView = enabledSwitch
        }
        
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */

}
