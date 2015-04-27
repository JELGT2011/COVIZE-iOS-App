//
//  CompanyProfile.swift
//  Pitch Events
//
//  Created by Cameron Jones on 3/22/15.
//  Copyright (c) 2015 Covize. All rights reserved.
//

import Foundation
import CoreData


class CompanyProfile: NSManagedObject, Printable{
    @NSManaged var name: String?
    @NSManaged var email: String?
    @NSManaged var company_name: String?
    @NSManaged var industry: String?
    @NSManaged var locale: String?
    @NSManaged var female_founder: Bool
    @NSManaged var ethnic_founder: Bool
    @NSManaged var prefer_local: Bool
    @NSManaged var prefer_industry: Bool
    @NSManaged var sort_event_start: Bool
    @NSManaged var sort_registration_deadline: Bool
    @NSManaged var capital_goal: String?
    @NSManaged var fundraising: String?
    @NSManaged var push_new_setting: Bool
    @NSManaged var push_favorite_setting: Bool
    
    override var description: String {
        return "Company Name: \(company_name), Email: \(email)\n"
    }
    
}