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
    
    //Set up Dumby events as a dictionary, like the json will be most likely doing
    
    let dummyEvents = [
        ["eventName":"SXSW", "eventDate":"2/18/2015", "eventDescription":"Add event description"],
        ["eventName":"Pitch 'n Hit Event", "eventDate":"2/29/2015", "eventDescription":"Add event description"],
        ["eventName":"Naturally Boulder", "eventDate":"4/15/2015", "eventDescription":"Add event description"],
        ["eventName":"Pitchlandia", "eventDate":"5/5/2015", "eventDescription":"Add event description"],
        ["eventName":"TechCrunch Pitch", "eventDate":"5/12/2015", "eventDescription":"Add event description"],
        ["eventName":"Winter Blues Buster", "eventDate":"6/3/2015", "eventDescription":"Add event description"],
        ["eventName":"Tri-State Ice Breaker", "eventDate":"6/15/2015", "eventDescription":"Add event description"],
        ["eventName":"Lucky Diamond", "eventDate":"6/20/2015", "eventDescription":"Add event description"]
    ]
    
    
    //This is a required function for a tableview. It controlls how many sections of the table is split into
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    //This is a required function for a tableview. It is used to set the number of rows to display in the tableview
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //Here we're setting the num of rows to the size of the dummy Dictionary of events
        return dummyEvents.count
    }
    
    //This is a required funtion for a tableview. This method is used to set the content in each row of the table
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //First we will initialize a UITableViewCell, we will also use the dequeResuable cell as it is good practice
        var cell = tableView.dequeueReusableCellWithIdentifier("event", forIndexPath: indexPath) as UITableViewCell
        
        //create an event object from the Dictionary of dummby data
        let event = dummyEvents[indexPath.row] as Dictionary
        
        //Now let's add the event data to the cell
       
        //First we will grab each element by calling the contentView.viewWithTag method. I have numbered each element with individual tags in the prototype cell in the storyboard. text labels are tags 1-3, and the images are 10 and 11
        
        //Set the event's name, date, and Description
        (cell.contentView.viewWithTag(1) as UILabel).text = event["eventName"] as String?
        (cell.contentView.viewWithTag(2) as UILabel).text = event["eventDate"] as String?
        (cell.contentView.viewWithTag(3) as UILabel).text = event["eventDescription"] as String?
        
        //Set the event's stock image and the button on the right of the cell which favorites them
        (cell.contentView.viewWithTag(10) as UIImageView).image = UIImage(named: "IconCell")
        (cell.contentView.viewWithTag(11) as UIButton).setImage(UIImage(named: "favoriteEmpty"), forState: .Normal)
        
        //Not a big fan of it highlighting the cells upon selection, so let's turn that off
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        
        return cell
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //requests events via json stream from the website
        fetchEvents() 
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Get JSON data from our URL
    func fetchEvents(){
        
        let urlPath: String = "https://website-covize-pitch-alerts-jelgt2011-1.c9.io/api/pitch_events/"
        
        //Link to Alamofire git hub page with resources https://github.com/Alamofire/Alamofire
        //This makes a call to the Alamofire library, currently the source code is in the project. The line with request make a GET call to the website, and the .response call following lets Alamofire know we are expecting a JSON in return
        request(.GET, "https://website-covize-pitch-alerts-jelgt2011-1.c9.io/api/pitch_events/")
            .responseJSON { (_, _, JSON, _) in
                //Now ween need to parse the JSON stream that comes in
                println(JSON)
        }
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
