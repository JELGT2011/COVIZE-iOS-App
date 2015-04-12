//
//  EventModel.swift
//  Pitch Events
//
//  Created by Deepan Mehta on 2/15/15.
//  Copyright (c) 2015 Covize. All rights reserved.
//

import Foundation

class EventModel: NSObject, Printable {
    let eventName: String
    let orgName: String
    let city: String
    let state: String
    let eventStart: String
    let eventEnd: String
    let regDeadline: String
    let eventLink: String
    let contactName: String
    let contactNumber: String
    let contactEmail: String
    let location: String
    let women: Bool
    let ethnic: String
    let industry: String
    
    override var description: String {
        return "Event Name: \(eventName), Organization: \(orgName)\n"
    }
    
    
    func getEventLocation() ->String{
        return city + ", " + state
    }
    
    //change start and end once we get db validation
    func getEventStart() ->String{
        return eventStart.substringToIndex(advance(eventStart.startIndex, 16))
        
    }
    
    func getEventEnd() ->String{
        return eventEnd.substringToIndex(advance(eventEnd.startIndex, 16))
        
    }
    
    func getContactInfo() ->String{
        return contactName +  " - " + contactNumber + "\n\nEmail: " + contactEmail
    }
    
    
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
}