//
//  EventTableViewController.swift
//  Pitch Events
//
//  Created by Cameron Jones on 2/15/15.
//  Copyright (c) 2015 Covize. All rights reserved.
//

import UIKit

class EventTableViewController: UIViewController, UITableViewDataSource {
    
    //Dumby events
    
    let dumbyEvents = [
        ("SXSW", "2/18/2015"),
        ("Pitch 'n Hit Event", "2/29/2015"),
        ("Naturally Boulder", "4/15/2015"),
        ("Pitchlandia", "5/5/2015"),
        ("TechCrunch Pitch", "5/12/2015"),
        ("Winter Blues Buster", "6/3/2015"),
        ("Tri-State Ice Breaker", "6/15/2015"),
        ("Lucky Diamond", "6/20/2015")
    ]
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dumbyEvents.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("event", forIndexPath: indexPath) as UITableViewCell
        
        let (eventTitle, eventDate) = dumbyEvents[indexPath.row]
        
        cell.textLabel?.text = eventTitle
        cell.detailTextLabel?.text = eventDate
        
        //add star icon
        var starIcon = UIImage(named: "IconCell")
        cell.imageView?.image = starIcon
        
        return cell
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
