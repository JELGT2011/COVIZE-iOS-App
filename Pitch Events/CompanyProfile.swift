//
//  CompanyProfile.swift
//  Pitch Events
//
//  Created by Austin Delk on 3/22/15.
//  Copyright (c) 2015 Covize. All rights reserved.
//

import Foundation


class CompanyProfile: NSObject, Printable{
    var name: String
    var email: String
    var password: String
    var companyName: String
    var industry: String
    var localeCity: String
    var localeState: String
    var femaleFounder: Bool
    var ethnicMinorityFounder: Bool
    var preferLocal: Bool
    var preferIndustry: Bool
    var capitalGoal: String
    var fundraisingStatus: String
    
    
    override init() {
        self.name = ""
        self.email = ""
        self.password = ""
        self.companyName = ""
        self.industry = ""
        self.localeCity = ""
        self.localeState = ""
        self.femaleFounder = false
        self.ethnicMinorityFounder = false
        self.preferIndustry = false
        self.preferLocal = false
        self.capitalGoal = ""
        self.fundraisingStatus = ""
        
    }
    
    func setCredentials(name: String, email: String, password: String){
        self.name = name
        self.email = email
        self.password = password
    }
    
    func setCompanyInfo(companyName: String, industry: String, city: String, state: String){
        self.companyName = companyName
        self.industry = industry
        self.localeCity = city
        self.localeState = state
    }
    
    func setProfileFilters(femaleFounder: Bool, ethnicMinorityFounder: Bool, preferLocal: Bool, preferIndustry: Bool, capitalGoal: String, fundraisingStatus: String){
        self.femaleFounder = femaleFounder
        self.ethnicMinorityFounder = ethnicMinorityFounder
        self.preferLocal = preferLocal
        self.preferIndustry = preferIndustry
        self.capitalGoal = capitalGoal
        self.fundraisingStatus = fundraisingStatus
        
    }
    
    
    
    
    
}