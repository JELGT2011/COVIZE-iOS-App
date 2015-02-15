//
//  EventModel.swift
//  Pitch Events
//
//  Created by Deepan Mehta on 2/15/15.
//  Copyright (c) 2015 Covize. All rights reserved.
//

import Foundation

class EventModel: NSObject, Printable {
    let event_name: String
    /*let org_name: String
    let city: String
    let state: String
    let event_start: String
    let event_end: String
    let registration_deadline: String
    let detail_link: String
    let contact_name: String
    let contact_number: String
    let contact_email: String
    let location: String
    let women: Boolean
    let ethnic: String
    let industry: String*/
    
    init(event_name: String?) {
        self.event_name = event_name ?? ""
    }
}