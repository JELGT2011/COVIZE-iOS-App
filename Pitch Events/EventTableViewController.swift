//
//  EventTableViewController.swift
//  Pitch Events
//
//  Created by Cameron Jones on 2/15/15.
//  Copyright (c) 2015 Covize. All rights reserved.
//

import UIKit
import CoreData


class EventTableViewController: UIViewController, UITableViewDataSource, NSURLConnectionDataDelegate{

    //UI Elements we need
    @IBOutlet weak var tableView: UITableView! //used to set cell data when populating events table
    @IBOutlet weak var menuButton: UIBarButtonItem! //gets the menuButton created in storyboard
    
    //Persistant variables
    var ApplicationDelegate: AppDelegate?
    var ManagedContext: NSManagedObjectContext?
    //var Events: [EventModel] = [EventModel]() //array to store events we get from the db
    var Events: [NSManagedObject] = [EventModel]()
    var companyProfile: NSManagedObject? //set to a blank profile, if new profile then set in new account views otherwise will persist from phone storage (TO-DO)
    var Favorites: [EventModel] = [EventModel]() //array to store events that have been marked as favorites (Persists TO-DO)
    
    
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
        let event = Events[indexPath.row] as EventModel
        
        //Now let's add the event data to the cell
       
        //First we will grab each element by calling the contentView.viewWithTag method. I have numbered each element with individual tags in the prototype cell in the storyboard. text labels are tags 1-3, and the images are 10 and 11
        
        //Set the event's name, date, and Description
        (cell.contentView.viewWithTag(1) as UILabel).text = event.valueForKey("event_name") as? String
        (cell.contentView.viewWithTag(2) as UILabel).text = event.getEventStart()
        (cell.contentView.viewWithTag(3) as UILabel).text = "hosted by " + (event.valueForKey("org_name") as String)
        
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
      
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        //initialize our application delegate and managed context variables so we can use core data
        ApplicationDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
        ManagedContext = ApplicationDelegate?.managedObjectContext
        
        //First thing we should do is request events via json stream from the website
        fetchEvents()
    }
    
    
    //Get events from db via JSON
    func fetchEvents(){
        
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
                    
                    //For whatever reason we have not been able to make contact with the database, let's tap into coredata and get the last set of events we pulled
                    let fetchRequest: NSFetchRequest = NSFetchRequest(entityName:"EventModel")
                    var error: NSError?
                    
                    //here we are asking the ManagedContext to fetch all entities with a the name "EventModel"
                    let fetchedResults = self.ManagedContext?.executeFetchRequest(fetchRequest, error: &error) as [NSManagedObject]?
                    
                    if let results = fetchedResults {
                        self.Events = results //we have fetched the last pulled events from coredata, set to the Events array
                    } else {
                        println("Could not fetch \(error), \(error!.userInfo)") //really striking out here...guess no saved events
                    }
                }
                else {
                    //Use the swiftyJson library to format the output from the website
                    let json = JSON(data!)
                    
                    //create an array of individual json entries
                    let eventArray = json.arrayValue
                    
                    //create an array of empty events, which follow the EventModel class
                    var events = [EventModel]()
                    
                    //First thing, before we parse the JSON response, let's get rid of all the old events
                    let fetchRequest: NSFetchRequest = NSFetchRequest(entityName:"EventModel")
                    var error: NSError?
                    let fetchedResults = self.ManagedContext?.executeFetchRequest(fetchRequest, error: &error) as [NSManagedObject]? //get those events
                    
                    //if we did get the events then let's step through the array of them and for each have the ManagedContext delete them
                    if let events = fetchedResults {
                        for event in events{
                            self.ManagedContext?.deleteObject(event)
                        }
                    }
                    
                    //For every json entry in the json array create a new EventModel object and story in events array
                    for eventDict in eventArray {
                        
                        //grab each data point from the json entry
                        var event_name: String? = eventDict["event_name"].stringValue
                        var org_name: String? = eventDict["org_name"].stringValue
                        var address_1: String? = eventDict["address_1"].stringValue //address_1 is street
                        var address_2: String? = eventDict["address_2"].stringValue //address_2 is additional address info
                        var city: String? = eventDict["city"].stringValue
                        var state: String? = eventDict["state"].stringValue
                        var zip: String? = eventDict["zip"].stringValue
                        var event_start: String? = eventDict["event_start"].stringValue
                        var event_end: String? = eventDict["event_end"].stringValue
                        var registration_deadline: String? = eventDict["registration_deadline"].stringValue
                        var detail_link: String? = eventDict["detail_link"].stringValue
                        //should also be a registration_link
                        var contact_name: String? = eventDict["contact_name"].stringValue
                        var contact_number: String? = eventDict["contact_number"].stringValue
                        var contact_email: String? = eventDict["contact_email"].stringValue
                        
                        //we need to take in longitude and lattitude to get city
                        var longitude: String? = eventDict["longitude"].stringValue
                        var lattitude: String? = eventDict["lattitude"].stringValue
                        var locale: String = "" //To be added to JSON
                        
                        //Event filtering flags
                        var women: Bool? = eventDict["women"].boolValue
                        var ethnic: Bool? = eventDict["ethnic"].boolValue
                        var industry: Bool? = eventDict["industry"].boolValue
                        
                        //create a new EventModel object
                        let entity =  NSEntityDescription.entityForName("EventModel", inManagedObjectContext: self.ManagedContext!)
                        
                        let event = NSManagedObject(entity: entity!, insertIntoManagedObjectContext:self.ManagedContext!) as EventModel
                        
                        //set JSON values to the new EventModel
                        event.setValue(event_name, forKey: "event_name")
                        event.setValue(org_name, forKey: "org_name")
                        event.setValue(address_1, forKey: "address_1")
                        event.setValue(address_2, forKey: "address_2")
                        event.setValue(city, forKey: "city")
                        event.setValue(state, forKey: "state")
                        event.setValue(zip, forKey: "zip")
                        event.setValue(event_start, forKey: "event_start")
                        event.setValue(event_end, forKey: "event_end")
                        event.setValue(registration_deadline, forKey: "registration_deadline")
                        event.setValue(detail_link, forKey: "detail_link")
                        //REGISTRATION LINK
                        event.setValue(contact_name, forKey: "contact_name")
                        event.setValue(contact_number, forKey: "contact_number")
                        event.setValue(contact_email, forKey: "contact_email")
                        event.setValue(longitude, forKey: "longitude")
                        event.setValue(lattitude, forKey: "lattitude")
                        event.setValue(locale, forKey: "locale")
                        event.setValue(women, forKey: "woman")
                        event.setValue(ethnic, forKey: "ethnic")
                        event.setValue(industry, forKey: "industry")
                        
                        //let's save these new events for a rainy day
                        var error: NSError?
                        if (self.ManagedContext?.save(&error) == false){
                            println("Could not save \(error), \(error?.userInfo)")
                        }
                        
                        //add this new event object to the events array
                        events.append(event)
                        
                    }
                    self.Events = events //Store the newly fetched events in the global array
                    
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
        if let detailedEventView = segue.destinationViewController as? DetailedEventViewController{
        
            if let indexPath = tableView.indexPathForSelectedRow() {
                let selectedEvent = Events[indexPath.row]
                detailedEventView.currentEvent = selectedEvent as? EventModel
                println("sending data to detail")
            
            }
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }


}
