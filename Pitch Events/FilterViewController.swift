//
//  FilterViewController.swift
//  Pitch Events
//
//  Created by Austin Delk on 2/15/15.
//  Copyright (c) 2015 Covize. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController, UITableViewDataSource {
    
    let sorting = [
        ("Date: Most Recent"),
        ("Proximity")
    ]
    
    let filters = [
        ("Industry Specific"),
        ("Minority Execuative"),
        ("Female Execuative")
    ]
    
    let recommended = [
        ("Use Recommended Filters")
    ]
    
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
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("filterSetting", forIndexPath: indexPath) as UITableViewCell
        
        if (indexPath.section == 0){
            cell.textLabel?.text = sorting[indexPath.row]
            
        } else if ( indexPath.section == 1){
            cell.textLabel?.text = filters[indexPath.row]
            
        } else {
            cell.textLabel?.text = recommended[indexPath.row]
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
