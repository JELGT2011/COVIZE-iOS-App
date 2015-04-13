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
    
    
    //change start and end once we get db validation
    func getEventStart() ->String?{
        return event_start.substringToIndex(advance(event_start.startIndex, 16))
        
    }
    
    func getEventEnd() ->String{
        return event_end.substringToIndex(advance(event_end.startIndex, 16))
        
    }
    
    func getContactInfo() ->String{
        return contact_name +  " - " + contact_number + "\n\nEmail: " + contact_email
    }
    
    func getEventLocation() ->String{
        return address_1 + " " + city + ", " + state + " " + zip
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