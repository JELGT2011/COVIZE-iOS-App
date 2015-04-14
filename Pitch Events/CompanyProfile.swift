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
    @NSManaged var capital_goal: String?
    @NSManaged var fundraising: String?
    
    override var description: String {
        return "Company Name: \(company_name), Email: \(email)\n"
    }
    
    /*
    override init() {
        self.femaleFounder = false
        self.eMFounder = false
        self.preferIndustry = false
        self.preferLocal = false
        
    }

    
    init(name: String, email:String, companyName: String, industry: String, locale: String, femaleFounder: Bool, eMFounder: Bool, preferIndustry: Bool, preferLocal: Bool, capitalGoal: String, fundraising: String) {
        self.name = name
        self.email = email
        self.companyName = companyName
        self.industry = industry
        self.locale = locale
        self.femaleFounder = femaleFounder
        self.eMFounder = eMFounder
        self.preferIndustry = preferIndustry
        self.preferLocal = preferLocal
        self.capitalGoal = capitalGoal
        self.fundraising = fundraising
        
    }
    
    */
}