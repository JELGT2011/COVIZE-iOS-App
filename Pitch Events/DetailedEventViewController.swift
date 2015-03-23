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
    @IBOutlet weak var OrganizationName: UILabel!
    @IBOutlet weak var EventDates: UILabel!
    @IBOutlet var EventDetailsLink: UIView!
    @IBOutlet weak var EventLocation: UILabel!
    @IBOutlet weak var EventDescription: UITextView!
    @IBOutlet weak var EventContacts: UITextView!
    @IBOutlet weak var EventName: UILabel!
    
    
    var currentEvent: EventModel = EventModel(eventName: "", orgName: "", city: "", state: "", eventStart: "", eventEnd: "", regDeadline: "", eventLink: "", contactName: "", contactNumber: "", contactEmail: "", location: "", women: false, ethnic: "", industry: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // take the event's data and set the labels
        EventName.text = currentEvent.getEventName()
        EventDescription.text = currentEvent.getEventStart()
        
        
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
