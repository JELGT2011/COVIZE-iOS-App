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
    @NSManaged var companyName: String?
    @NSManaged var industry: String?
    @NSManaged var locale: String?
    @NSManaged var femaleFounder: Bool
    @NSManaged var eMFounder: Bool
    @NSManaged var preferLocal: Bool
    @NSManaged var preferIndustry: Bool
    @NSManaged var capitalGoal: String?
    @NSManaged var fundraising: String?
    
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