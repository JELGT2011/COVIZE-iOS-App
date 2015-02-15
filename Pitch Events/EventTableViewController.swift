//
//  EventTableViewController.swift
//  Pitch Events
//
//  Created by Cameron Jones on 2/15/15.
//  Copyright (c) 2015 Covize. All rights reserved.
//

import UIKit

class EventTableViewController: UIViewController, UITableViewDataSource, NSURLConnectionDataDelegate {
    
    var data = NSMutableData()
    //Dumby events
    
    let dummyEvents = [
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
        return dummyEvents.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("event", forIndexPath: indexPath) as UITableViewCell
        
        let (eventTitle, eventDate) = dummyEvents[indexPath.row]
        
        cell.textLabel?.text = eventTitle
        cell.detailTextLabel?.text = eventDate
        
        //add star icon
        var starIcon = UIImage(named: "IconCell")
        cell.imageView?.image = starIcon
        
        return cell
    }
    
    override func viewDidLoad() { //attempt to pull JSON if view loads (code based on JSON/swift tutorial found here: http://www.raywenderlich.com/82706/working-with-json-in-swift-tutorial )
        
        super.viewDidLoad()
        //startConnection() //starts json connection

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /* //meant to get JSON data from our URL, doesn't currently work
    func startConnection(){
        let urlPath: String = "https://website-covize-pitch-alerts-jelgt2011-1.c9.io/api/pitch_events/"
        var url: NSURL = NSURL(string: urlPath)!
        var request: NSURLRequest = NSURLRequest(URL: url)
        var connection: NSURLConnection = NSURLConnection(request: request, delegate: self, startImmediately: false)!
        connection.start()
    }
    
    func connection(connection: NSURLConnection!, didReceiveData data: NSData!){
        self.data.appendData(data)
    }
    
    func buttonAction(sender: UIButton!){
        
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection!) {
        // throwing an error on the line below (can't figure out where the error message is)
        var err: NSError
        //var jsonResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
        //println(jsonResult)
  
    }
    */
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */

}
