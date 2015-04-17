//
//  DetailedEventViewController.swift
//  Pitch Events
//
//  Created by Austin Delk on 3/12/15.
//  Copyright (c) 2015 Covize. All rights reserved.
//

import UIKit

class DetailedEventViewController: UIViewController {
    
    //This variable will be set as the EventTableViewController's prepare for segue method is called
    var eventTable: UITableView? //set from EventTableView, need to be able to call refresh so that changes to favorited status are seen
    var currEvent: EventModel?
    var appDelegate: AppDelegate?
    
    @IBOutlet weak var EventLogo: UIImageView!
    @IBOutlet weak var EventName: UILabel!
    @IBOutlet weak var OrgName: UILabel!
    @IBOutlet weak var RegDeadline: UILabel!
    @IBOutlet weak var RegLinkButton: UIButton!
    @IBOutlet weak var EventDetailButton: UIButton!
    @IBOutlet weak var FavButton: UIButton!
    @IBOutlet weak var EventAddress: UILabel!
    @IBOutlet weak var EventDates: UILabel!
    @IBOutlet weak var ContactInfoHeader: UILabel!
    @IBOutlet weak var ContactName: UILabel!
    @IBOutlet weak var ContactEmail: UILabel!
    @IBOutlet weak var ContactNumber: UILabel!
    
    
    //Set's the info button next to the registration date to the registration date
    @IBAction func RegLink(sender: AnyObject) {
        if(currEvent?.registration_link.isEmpty == false){
            if let regLink = NSURL(string: "www.google.com"/*(currEvent?.registration_link)!*/){
                UIApplication.sharedApplication().openURL(regLink)
            }
        }
    }
    
    //Sets the info button next to the details header to the details link
    @IBAction func EventDetailLink(sender: AnyObject) {
        if(currEvent?.detail_link.isEmpty == false){
            if let detailLink = NSURL(string: "http://www.google.com"/*(currEvent?.detail_link)!*/){
                UIApplication.sharedApplication().openURL(detailLink)
            }
        }
    }
    
    @IBAction func FavButton(sender: AnyObject) {
        //when star is clicked set this event to a favorite (set its favorited:Bool, add it to the Favorites[] in app delegate, and change the image to FavoriteFull
        if(currEvent?.favorited == false){
            currEvent?.favorited = true
            appDelegate?.Favorites.append(currEvent!)
            FavButton.setImage(UIImage(named: "favoriteFull"), forState: .Normal)
            eventTable?.reloadData()
        } else {
            currEvent?.favorited = false
            
            var i = 0
            if let favEvents = appDelegate?.Favorites{ //makes sure the Favorites exists, should be 100% of the time
                if let currE = currEvent?{ //makes sure that currEvent exists, should also be 100% of the time
                    var favEvent = favEvents[i] //grab the first event from the Favorites array
                    
                    //Now we need to itterate through the Favorite array and check each event for equality. If we find an equal then we will now have its index so we can remove it
                    while((favEvent.equals(currE) == false) && (favEvents.count > i+1)){ //if not equal and we are not at the last index
                        i++ //increase index
                        favEvent = favEvents[i] //set favEvent to the next event in the favorites array
                    }
                    
                    //Now that we have found the index remove it from the array
                    appDelegate?.Favorites.removeAtIndex(i)
                }
            }
            
            FavButton.setImage(UIImage(named: "favoriteEmpty"), forState: .Normal)
            eventTable?.reloadData()
            
        }
        println("Favorites: \(appDelegate?.Favorites.count)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
        
        if(currEvent?.favorited == true){
            FavButton.setImage(UIImage(named: "favoriteFull"), forState: .Normal)
            FavButton.frame = CGRectMake(354,93,30,26)
        } else {
            FavButton.setImage(UIImage(named: "favoriteEmpty"), forState: .Normal)
        }
        
        if(currEvent?.registration_link.isEmpty == true){
            RegLinkButton.hidden = true
        }
        
        if(currEvent?.detail_link.isEmpty == true){
            EventDetailButton.hidden = true
        }
        
        // take the event's data and set the labels
        //EventLogo
        EventName.text = currEvent?.event_name
        OrgName.text = currEvent?.org_name
        EventAddress.text = currEvent?.getEventAddress() //check get Location to make sure it outputs correct
        EventDates.text = currEvent?.getEventDateRange() //create getEvent Start that does date range then times
        RegDeadline.text = "Register by: " + (currEvent?.getRegistrationDeadline())! //sets the registration deadline to the label
        
        checkContactInfo(currEvent?.contact_name, contactEmail: currEvent?.contact_email, contactNumber: currEvent?.contact_number) //see if any contact info was giver otherwise hide the elements
    }
    
    func checkContactInfo(contactName:String?, contactEmail:String?, contactNumber:String?){
        if(currEvent?.isContactInfo() == true){
            if(contactName?.isEmpty == false){
                ContactName.text = contactName?
                
                if(contactEmail?.isEmpty == false){ //check to see if email is empty
                    ContactEmail.text = contactEmail?
                    
                } else if(contactNumber?.isEmpty == false){ //contact email was not entered so set number to its place and set the number label to hidden
                    ContactEmail.text = contactNumber?
                    ContactNumber.hidden = true
                    
                } else{ //both email and number were left blank hide them both
                    ContactEmail.hidden = true
                    ContactNumber.hidden = true
                }
            } else if(contactEmail?.isEmpty == false){ //name was left off put the email in the name slot
                ContactName.text = contactEmail?
                
                if(contactNumber?.isEmpty == false){ //number isn't blank so set it to the email field and hide contact number label
                    ContactEmail.text = contactNumber?
                    ContactNumber.hidden = true
                } else { //only email given so hide both the O.G. email slot and number
                    ContactEmail.hidden = true
                    ContactNumber.hidden = true
                }
            } else if(contactNumber?.isEmpty == false){ //number was the only thing provided set that to name's slot and hide others
                ContactName.text = contactNumber?
                ContactEmail.hidden = true
                ContactNumber.hidden = true
            }
        } else { //if none than hide the contact info label
            ContactInfoHeader.hidden = true
            ContactName.hidden = true
            ContactEmail.hidden = true
            ContactNumber.hidden = true
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //really only one segue that can be preformed, back to event table view, so let's tell it to refresh the table in case this event is now a favorite or not a favorite anymore
        
    }


}
