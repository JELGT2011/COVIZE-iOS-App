//
//  EventTableViewController.swift
//  Pitch Events
//
//  Created by Cameron Jones on 2/15/15.
//  Copyright (c) 2015 Covize. All rights reserved.
//

import UIKit

class EventTableViewController: UIViewController, UITableViewDataSource, NSURLConnectionDataDelegate{
    
    var data = NSMutableData()
    
    @IBOutlet weak var tableView: UITableView!
    
    // Get JSON data from our URL
    
    //Set up Dumby events as a dictionary, like the json will be most likely doing
    var Events: [EventModel] = [EventModel]()
    
    //This is a required function for a tableview. It controlls how many sections of the table is split into
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    //This is a required function for a tableview. It is used to set the number of rows to display in the tableview
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //Here we're setting the num of rows to the size of the dummy Dictionary of events
        return Events.count
    }
    
    //This is a required funtion for a tableview. This method is used to set the content in each row of the table
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //First we will initialize a UITableViewCell, we will also use the dequeResuable cell as it is good practice
        var cell = tableView.dequeueReusableCellWithIdentifier("event", forIndexPath: indexPath) as UITableViewCell
        
        //create an event object from the Dictionary of dummby data
        let event = Events[indexPath.row]
        
        //Now let's add the event data to the cell
       
        //First we will grab each element by calling the contentView.viewWithTag method. I have numbered each element with individual tags in the prototype cell in the storyboard. text labels are tags 1-3, and the images are 10 and 11
        
        //Set the event's name, date, and Description
        (cell.contentView.viewWithTag(1) as UILabel).text = event.eventName
        (cell.contentView.viewWithTag(2) as UILabel).text = event.getEventStart()
        (cell.contentView.viewWithTag(3) as UILabel).text = "hosted by " + event.orgName
        
        //Set the event's stock image and the button on the right of the cell which favorites them
        (cell.contentView.viewWithTag(10) as UIImageView).image = UIImage(named: "IconCell")
        (cell.contentView.viewWithTag(11) as UIButton).setImage(UIImage(named: "favoriteEmpty"), forState: .Normal)
        
        //Not a big fan of it highlighting the cells upon selection, so let's turn that off
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        
        return cell
    }
    
    //Called as the first method once this view has been set to be displayed
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //First thing we should do is request events via json stream from the website
        fetchEvents()
    }
    
    
    //COMMENT LATER
    func fetchEvents(){
        
        var retEvents: [EventModel] = [EventModel]()
        
        //create a variable url that we can appened arguments to in order to limit event sizing ect.
        var url = "http://covize-pitch-alerts.herokuapp.com/api/pitch_events"
        url = buildURL(url)
        
        let urlPath: String = url
        
        //Link to Alamofire git hub page with resources https://github.com/Alamofire/Alamofire
        //This makes a call using the Alamofire library, currently the source code is in the project
        
        //This line makes a GET call to the website, and then lets Alamofire know we are expecting a JSON in return
        request(.GET, urlPath)
            .responseJSON { (_, _, data, error) in
                //Now ween need to parse the JSON stream that comes in
                if(error != nil) {
                    NSLog("Error: \(error)")
                }
                else {
                    //Use the swiftyJson library to format the output from the website
                    let json = JSON(data!)
                    
                    //create an array of individual json entries
                    let eventArray = json.arrayValue
                    
                    //create an array of empty events, which follow the EventModel class
                    var events = [EventModel]()
                    
                    //For every json entry in the json array create a new EventModel object and story in events array
                    for eventDict in eventArray {
                        
                        //grab each data point from the json entry
                        var eventName: String? = eventDict["event_name"].stringValue
                        var orgName: String? = eventDict["org_name"].stringValue
                        //address_1 is street
                        //address_2 is additional address info
                        var city : String? = eventDict["city"].stringValue
                        var state: String = eventDict["state"].stringValue
                        //zip is zip
                        var eventStart: String = eventDict["event_start"].stringValue
                        var eventEnd: String = eventDict["event_end"].stringValue
                        var regDeadline: String = eventDict["registration_deadline"].stringValue
                        var eventLink: String = eventDict["detail_link"].stringValue
                        var contactName: String = eventDict["contact_name"].stringValue
                        var contactNumber: String = eventDict["contact_number"].stringValue
                        var contactEmail: String = eventDict["contact_email"].stringValue
                        
                        //we need to take in longitude and lattitude to get city
                        var location: String = ""
                        
                        //women is taken in right now as bool, but ethnic is now and SHOULD be
                        var women: Bool = eventDict["women"].boolValue
                        var ethnic: String = eventDict["ethnic"].stringValue
                        var industry: String = eventDict["industry"].stringValue
                        
                        //create a new EventModel object
                        var event = EventModel(eventName: eventName, orgName: orgName, city: city, state: state, eventStart: eventStart, eventEnd: eventEnd, regDeadline: regDeadline, eventLink: eventLink, contactName: contactName, contactNumber: contactNumber, contactEmail: contactEmail, location: location, women: women, ethnic: ethnic, industry: industry)
                        
                        //add this new event object to the events array
                        events.append(event)
                    }
                    self.Events = events
                    
                    //Once the request returns we need to tell the table to refresh
                    self.tableView.reloadData()
                }
        }   
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    func buildURL(url: String) -> String{
        //TO-DO
        //do a check here to determine what flags are set in company profile, i.e. preferLocation, preferIndustry, womanFounder, etc.
        //Also if this is the free version only allow 5 events to be pulled
        
        //right now for testing let's just pull 10 events to view
        var newURL = url + "?limit=10"
        
        return newURL
    
    }
    
    
    // This method is called before each transition between views
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // Check to see if we are transitioning to the detailed event view
        if let detailedEventVeiw = segue.destinationViewController as? DetailedEventViewController{
        
            if let indexPath = tableView.indexPathForSelectedRow() {
                let selectedEvent = Events[indexPath.row]
                detailedEventVeiw.currentEvent = selectedEvent
                println("sending data to detail")
            
            }
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }


}
