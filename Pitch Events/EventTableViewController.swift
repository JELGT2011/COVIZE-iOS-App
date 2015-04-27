//
//  EventTableViewController.swift
//  Pitch Events
//
//  Created by Cameron Jones on 2/15/15.
//  Copyright (c) 2015 Covize. All rights reserved.
//

import UIKit
import CoreData


class EventTableViewController: UIViewController, UITableViewDataSource, NSURLConnectionDataDelegate, ADBannerViewDelegate{

    //UI Elements we need
    @IBOutlet weak var tableView: UITableView! //used to set cell data when populating events table
    @IBOutlet weak var menuButton: UIBarButtonItem! //gets the menuButton created in storyboard
    @IBOutlet weak var ViewFavoritEventsButton: UIBarButtonItem! //button used to toggle the favorited events in the table or searched events
    @IBOutlet weak var AdBanner: ADBannerView!
    @IBOutlet weak var TotalEventsLabel: UILabel!
    
    //Persistant variables
    var ApplicationDelegate: AppDelegate?
    var ManagedContext: NSManagedObjectContext?
    //var Events: [EventModel] = [EventModel]() //array to store events we get from the db
    var Events: [NSManagedObject] = [EventModel]()
    var companyProfile: CompanyProfile? //will always be grabbed from core data in viewDidLoad
    var Favorites: [EventModel] = [EventModel]() //array to store events that have been marked as favorites (Persists TO-DO)
    var FavoritesDisplayed: Bool = false
    
    
    
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
        var cell = tableView.dequeueReusableCellWithIdentifier("event", forIndexPath: indexPath) as! EventTableCell
        
        //create an event object from the Dictionary of dummby data
        let event = Events[indexPath.row] as! EventModel
        
        //Now let's add the event data to the cell
        cell.Title.text = event.valueForKey("event_name") as? String
        cell.Organization.text = "hosted by " + (event.valueForKey("org_name") as! String)
        cell.Location.text = event.getLocale()
        cell.Dates.text = event.getEventDateRange()
        cell.RegistrationDeadline.text = "Register by: " + event.getRegistrationDeadline()!

        //Set the event's stock image and the button on the right of the cell which favorites them
        //Haven't set up downloading a logo image for now let's default to the place holder
        /* let logoImage = UIImage(data: event.logo)
        
        if(logoImage != nil){
            cell.Logo.image = logoImage
        } else{
            cell.Logo.image = UIImage(named: "pitchAlertsBaloon")
        } */
        
        cell.Logo.image = UIImage(named: "pitchAlertsBaloon")
        
        var favButton: UIButton = cell.FavoriteButton
        favButton.tag = indexPath.row
        favButton.addTarget(self, action: "favButtonAction:", forControlEvents: .TouchUpInside)
        
        if(event.favorited == true){
            favButton.setImage(UIImage(named: "FavoritedFull"), forState: .Normal)
        } else {
            favButton.setImage(UIImage(named: "FavoritedEmpty"), forState: .Normal)
        }
        
        //Let's set the registration button stuff if there is a link otherwise hide it
        var regButton: UIButton = cell.RegistrationButton
        if(event.registration_link.isEmpty == false){
            regButton.hidden = false
            regButton.tag = indexPath.row
            regButton.addTarget(self, action: "regButtonAction:", forControlEvents: .TouchUpInside)
        } else{
            regButton.hidden = true
        }
        
        //Not a big fan of it highlighting the cells upon selection, so let's turn that off
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        return cell
    }
    
    func favButtonAction(sender: AnyObject) {
        //Attempt to get event from the sender
        var favButton = sender as? UIButton
        var currEvent = Events[favButton!.tag] as? EventModel
        
        //when star is clicked set this event to a favorite (set its favorited:Bool, add it to the Favorites[] in app delegate, and change the image to FavoriteFull
        if(currEvent?.favorited == false){
            currEvent?.favorited = true
            self.ApplicationDelegate?.Favorites.append(currEvent!)
            self.tableView.reloadData()
        } else {
            currEvent?.favorited = false
            
            //Get the index of the event in the App Delegate's Favorites array
            var i = 0
            if let favEvents = self.ApplicationDelegate?.Favorites{ //makes sure the Favorites exists, should be 100% of the time
                if let currE = currEvent{ //makes sure that currEvent exists, should also be 100% of the time
                    var favEvent = favEvents[i] //grab the first event from the Favorites array
                    
                    //Now we need to itterate through the Favorite array and check each event for equality. If we find an equal then we will now have its index so we can remove it
                    while((favEvent.equals(currE) == false) && (favEvents.count > i+1)){ //if not equal and we are not at the last index
                        i++ //increase index
                        favEvent = favEvents[i] //set favEvent to the next event in the favorites array
                    }
                    
                    //Now that we have found the index remove it from the array
                    self.ApplicationDelegate?.Favorites.removeAtIndex(i)
                }
            }
            self.tableView.reloadData()
            
        }
        println("Favorites: \(self.ApplicationDelegate?.Favorites.count)")
    }
    
    func regButtonAction(sender: AnyObject){
        if let regButton = sender as? UIButton {
            var currEvent = Events[regButton.tag] as! EventModel
            if(currEvent.registration_link.isEmpty == false){
                if let regLink = NSURL(string: currEvent.registration_link){
                    UIApplication.sharedApplication().openURL(regLink)
                }
            }
        }
    }
    
    //Ad Banner Delegate Methods
    func bannerViewWillLoadAd(banner: ADBannerView!) {
        
    }
    
    //iAd has an ad to be displayed
    func bannerViewDidLoadAd(banner: ADBannerView!) {
        //show the ad banner
        UIView.animateWithDuration(0.5, animations: {
            self.AdBanner.hidden = false
        })
    }
    
    func bannerViewActionShouldBegin(banner: ADBannerView!, willLeaveApplication willLeave: Bool) -> Bool {
        return true
    }
    
    func bannerViewActionDidFinish(banner: ADBannerView!) {
        
    }
    
    //For some reason there are no ads to display
    func bannerView(banner: ADBannerView!, didFailToReceiveAdWithError error: NSError!) {
        //hide the ad banner
        UIView.animateWithDuration(0.5, animations: {
            self.AdBanner.hidden = true
        })
    }
    
    //Called as the first method once this view has been set to be displayed
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //change color of nav bar
        UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: false)
        navigationController?.navigationBar.barTintColor = HextoColor.uicolorFromHex(0x13342A)
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.whiteColor()
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.whiteColor()
        
        //initialize our application delegate and managed context variables so we can use core data
        ApplicationDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
        ManagedContext = ApplicationDelegate?.managedObjectContext!
        
        companyProfile = ApplicationDelegate?.companyProfile
        println("Company-EventView: \(companyProfile?.company_name)")
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        //set up the Advertisements
        self.AdBanner.delegate = self
        self.AdBanner.hidden = true
        
        //First thing we should do is request events via json stream from the website
        //Don't want to be making calls to the db all the time so the global var refreshEvents (in AppDelegate) will handle when we want to, if we don't then we need to pull events from the app delegate
        if(ApplicationDelegate?.refreshEvents == true){
            fetchEvents()
        } else {
            self.Events = (ApplicationDelegate?.Events)!
        }
        
        //Let's set a timer to update the events from the data base every XXX amount of time (Either passively or actively)
        //let timer = NSTimer.scheduledTimerWithTimeInterval(600.0, target: self, selector: "updateEvents", userInfo: nil, repeats: false) //10mins
    }
    
    //Action for the ViewFavoriteEventsButton
    @IBAction func ViewFavoriteEventsToggle(sender: AnyObject) {
        //check FavoritesDisplayed
        if(FavoritesDisplayed == false){
            //then we will set to true, set Events var to the app delegate's Favorites array, and tell table to refresh
            self.FavoritesDisplayed = true
            if let favEvents = ApplicationDelegate?.Favorites{
                self.Events = favEvents
                tableView.reloadData()
                self.ViewFavoritEventsButton.image = UIImage(named: "Search") //also set the button's title so that its intuitive how to get back to reg view
            }
        } else {
            //favs are currently shown. set favoritesDisplayed to false, set Events back to appDelegate's Events car, tell table to refresh
            self.FavoritesDisplayed = false
            if let events = ApplicationDelegate?.Events{
                self.Events = events
                tableView.reloadData()
                self.ViewFavoritEventsButton.image = UIImage(named: "FavoritedFull") //set title back to O.G.
            }
        }
    }
    
    func updateEvents(){
        //can passively fetch events. now whenever the next time the Event table view is shown it will do it automatically
        //refreshEvents = true
        //OR we could activly fetch events here. Might be better because this would allow us to then to push notifications
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
        
        
        request(.GET, urlPath).responseJSON { (_, _, data, error) in
                //Now ween need to parse the JSON stream that comes in
                if(error != nil) {
                    NSLog("Error: \(error)")
                    
                    //For whatever reason we have not been able to make contact with the database, let's tap into coredata and get the last set of events we pulled
                    let fetchRequest: NSFetchRequest = NSFetchRequest(entityName:"EventModel")
                    var error: NSError?
                    
                    //here we are asking the ManagedContext to fetch all entities with a the name "EventModel"
                    let fetchedResults = self.ManagedContext?.executeFetchRequest(fetchRequest, error: &error) as! [NSManagedObject]?
                    
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
                    self.ApplicationDelegate?.Favorites.removeAll() //we need to clear the favorites array because we will repopulate it later
                    
                    //First thing, before we parse the JSON response let's get rid of all the old events. EXCEPT for when the events have been marked as favorites in that case let's keep them for later. But we won't add them to the events array so they aren't displayed unless on the favorite view
                    let fetchRequest: NSFetchRequest = NSFetchRequest(entityName:"EventModel")
                    var error: NSError?
                    let fetchedResults = self.ManagedContext?.executeFetchRequest(fetchRequest, error: &error) as! [NSManagedObject]? //get those events
                    
                    //if we did get the events then let's step through the array of them and for each have the ManagedContext delete them
                    if let events = fetchedResults {
                        for event in events{
                            if (event as! EventModel).favorited == false{
                                self.ManagedContext?.deleteObject(event)
                            } else {
                                self.ApplicationDelegate?.Favorites.append(event as! EventModel)
                            }
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
                        var registration_link: String? = eventDict["registration_link"].stringValue
                        var contact_name: String? = eventDict["contact_name"].stringValue
                        var contact_number: String? = eventDict["contact_number"].stringValue
                        var contact_email: String? = eventDict["contact_email"].stringValue
                        
                        //we need to take in longitude and lattitude to get city
                        //var longitude: String? = eventDict["longitude"].stringValue //not using these
                        //var lattitude: String? = eventDict["lattitude"].stringValue //not using these
                        var locale: String = eventDict["locale"].stringValue
                        
                        //Event filtering flags
                        var women: Bool? = eventDict["women"].boolValue
                        var ethnic: Bool? = eventDict["ethnic"].boolValue
                        var industry: Bool? = eventDict["industry"].boolValue
                        
                        //create a new EventModel object
                        let entity =  NSEntityDescription.entityForName("EventModel", inManagedObjectContext: self.ManagedContext!)
                        
                        let event = NSManagedObject(entity: entity!, insertIntoManagedObjectContext:self.ManagedContext!) as! EventModel
                        
                        //Now let's first take in the logo's url, and kick off the method to download it
                        var base_url = "http://www.covize-pitch-alerts.herokuapp.com"
                        let logo_url = eventDict["photo"].stringValue //get the path of the image from the event
                        
                        if logo_url == "/photos/original/missing.png"{
                            //this is the default value for the photo but is not a real url TO-DO set the Logo as something by default
                        } else {
                            //This is where we would want to download the image
                        }
                        
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
                        event.setValue(registration_link, forKey: "registration_link")
                        event.setValue(contact_name, forKey: "contact_name")
                        event.setValue(contact_number, forKey: "contact_number")
                        event.setValue(contact_email, forKey: "contact_email")
                        //event.setValue(longitude, forKey: "longitude")
                        //event.setValue(lattitude, forKey: "lattitude")
                        event.setValue(locale, forKey: "locale")
                        event.setValue(women, forKey: "woman")
                        event.setValue(ethnic, forKey: "ethnic")
                        event.setValue(industry, forKey: "industry")
                        event.setValue(false, forKey: "favorited") //set each event as default to non-favorited
                        
                        //let's save these new events for a rainy day
                        var error: NSError?
                        if (self.ManagedContext?.save(&error) == false){
                            println("Could not save \(error), \(error?.userInfo)")
                        }
                        
                        //add this new event object to the events array
                        events.append(event)
                        
                    }
                    self.Events = events //Store the newly fetched events in the array
                    self.ApplicationDelegate?.Events = events //Store in the global Application Delegat array as well
                    
                    //TO-DO- Jason needs to add ability to see how many total events meet the filter criteria
                    self.TotalEventsLabel.text = "Showing \(events.count) of 100 events"
                    
                    //Once the request returns we need to tell the table to refresh
                    self.tableView.reloadData()
                }
        }
        ApplicationDelegate?.refreshEvents = false //set to false so that events don't keep being pulled
    }
    
    //TO-DO
    func buildURL(url: String) -> String{
        //do a check here to determine what flags are set in company profile, i.e. preferLocation, preferIndustry, womanFounder, etc.
        //Also if this is the free version only allow 5 events to be pulled
        
        var female_founder = companyProfile?.female_founder
        var ethnic_founder = companyProfile?.ethnic_founder
        var prefer_local = companyProfile?.prefer_local
        var prefer_industry = companyProfile?.prefer_industry
        var sort_event_start = companyProfile?.sort_event_start
        var sort_registration_deadline = companyProfile?.sort_registration_deadline
        
        //By default this intial app is the free version, so only 5 events will be pulled from the db at a time
        var limit = 5
        var st_index = 0
        var newURL = url + "?starting_index=\(st_index)&ending_index=\(limit)"
        newURL += (female_founder == true) ? "&woman_founder=true" : ""
        newURL += (ethnic_founder == true) ? "&ethnic_founder=true" : ""
        newURL += (prefer_local == true) ? "&locale=\(companyProfile?.locale!)" : ""
        newURL += (prefer_industry == true) ? "&industry=true" : ""
        newURL += (sort_event_start == true) ? "&sort_order=event_start": ""
        newURL += (sort_registration_deadline == true) ? "&sort_order=registration_deadline" : ""
        
        return newURL
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //This method is called before each transition between views
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // Check to see if we are transitioning to the detailed event view
        if let detailedEventView = segue.destinationViewController as? DetailedEventViewController{
        
            if let indexPath = tableView.indexPathForSelectedRow() {
                let selectedEvent = Events[indexPath.row]
                detailedEventView.currEvent = selectedEvent as? EventModel
                detailedEventView.eventTable = self.tableView
                println("sending data to detail")
            
            }
        }
    }


}
