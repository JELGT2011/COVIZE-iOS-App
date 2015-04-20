//
//  EventModel.swift
//  Pitch Events
//
//  Created by Cameron Jones on 2/15/15.
//  Copyright (c) 2015 Covize. All rights reserved.
//

import Foundation
import CoreData

class EventModel: NSManagedObject, Printable {
    @NSManaged var favorited: Bool
    @NSManaged var event_name: String
    @NSManaged var org_name: String
    @NSManaged var address_1: String
    @NSManaged var address_2: String
    @NSManaged var city: String
    @NSManaged var state: String
    @NSManaged var zip: String
    @NSManaged var event_start: String
    @NSManaged var event_end: String
    @NSManaged var registration_deadline: String
    @NSManaged var detail_link: String
    @NSManaged var registration_link: String
    @NSManaged var contact_name: String
    @NSManaged var contact_number: String
    @NSManaged var contact_email: String
    @NSManaged var longitude: String
    @NSManaged var lattitude: String
    @NSManaged var locale: String
    @NSManaged var women: Bool
    @NSManaged var ethnic: String
    @NSManaged var industry: String
    
    override var description: String {
        return "Event Name: \(event_name), Organization: \(org_name)\n"
    }
    
    //simple euality check, we'll say that any event that has the same name is the same event
    func equals(object: AnyObject?) -> Bool {
        return (object as! EventModel).event_name == self.event_name
    }
    
    //ex. Dec 25, 2015
    func getRegistrationDeadline() ->String?{
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.xxxx"
        let regDeadline = dateFormatter.dateFromString(registration_deadline)
        
        dateFormatter.dateStyle = .MediumStyle //ex. Dec 25, 2015
        
        let dateString = dateFormatter.stringFromDate(regDeadline!)
        
        return dateString
    }
    
    //ex. Dec 25, 2015 at 7:00 AM
    func getEventStart() ->String{
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.xxxx"
        let startDate = dateFormatter.dateFromString(event_start)
        
        dateFormatter.dateStyle = .MediumStyle //ex. Dec 25, 2015
        dateFormatter.timeStyle = .ShortStyle //ex. 7:00 AM
        
        let dateString = dateFormatter.stringFromDate(startDate!)
        
        return dateString
    }
    
    //ex. Dec 25, 2015 at 7:00 AM
    func getEventEnd() ->String{
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.xxxx"
        let endDate = dateFormatter.dateFromString(event_end)
        
        dateFormatter.dateStyle = .MediumStyle //ex. Dec 25, 2015
        dateFormatter.timeStyle = .ShortStyle //ex. 7:00 AM
        
        let dateString = dateFormatter.stringFromDate(endDate!)
        
        return dateString
        
    }
    
    //ex. 12/23/15 - 12/25/15
    func getEventDateRange() ->String{
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.xxxx"
        let startDate = dateFormatter.dateFromString(event_start)
        let endDate = dateFormatter.dateFromString(event_end)
        
        dateFormatter.dateStyle = .ShortStyle //ex. 12/25/15
        
        let startString = dateFormatter.stringFromDate(startDate!)
        let endString = dateFormatter.stringFromDate(endDate!)

        return startString + " - " + endString
    }
    
    //ex. 123 Fairgrounds Ct 7235(condo # or something) Atlanta, GA 3-313
    func getEventLocation() ->String{
        return address_1 + " " + address_2 + " " + city + ", " + state + " " + zip
    }
    
    //ex. 123 Fairgrounds Ct Atlanta, GA
    func getEventAddress() ->String{
        return address_1 + " " + city + ", " + state
    }
    
    func getLocale() ->String{
        return city + ", "  + state
    }
    
    //makes sure that at least one piece of contact info isn't empty, otherwise we won't show the contact section in the detailed event page
    func isContactInfo() ->Bool{
        if(contact_name.isEmpty == false){
            return true
        } else if(contact_email.isEmpty == false){
            return true
        } else if (contact_number.isEmpty == false){
            return true
        }else {
            return false
        }
    }
    
    /*
    init(eventName: String?, orgName: String?, city: String?, state: String?, eventStart: String, eventEnd: String?, regDeadline: String?, eventLink: String?, contactName: String?, contactNumber: String?, contactEmail: String?, location: String?, women: Bool?, ethnic: String?, industry: String?) {
        
        self.eventName = eventName ?? ""
        self.orgName = orgName ?? ""
        self.city = city ?? ""
        self.state = state ?? ""
        self.eventStart = eventStart ?? ""
        self.eventEnd = eventEnd ?? ""
        self.regDeadline = regDeadline ?? ""
        self.eventLink = eventLink ?? ""
        self.contactName = contactName ?? ""
        self.contactNumber = contactNumber ?? ""
        self.contactEmail = contactEmail ?? ""
        self.location = location ?? ""
        self.industry = industry ?? ""
        self.women = women ?? false
        self.ethnic = ethnic ?? ""
        
    }
    */
}