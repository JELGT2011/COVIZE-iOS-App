//
//  CompanyInfoViewController.swift
//  Pitch Events
//
//  Created by Cameron Jones on 4/3/15.
//  Copyright (c) 2015 Covize. All rights reserved.
//

import Foundation
import CoreData

class CompanyInfoViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var Industry: UITextField!
    @IBOutlet weak var Locale: UITextField!
    @IBOutlet weak var ErrorLabel: UILabel!
    @IBOutlet weak var Fundraising: UITextField!
    @IBOutlet weak var CapitalGoal: UITextField!
    
    var industryPicker: UIPickerView?
    var localePicker: UIPickerView?
    var fundPicker: UIPickerView?
    var capPicker: UIPickerView?
    var industryData = [ "Select closest match",
                    "CleanTech and Energy",
                    "Education",
                    "Business Operations",
                    "Fashion and Design",
                    "Finance",
                    "Food and Beverage",
                    "Gaming",
                    "Healthcare, Medical Devices/BioTech",
                    "Media and Entertainment",
                    "Retail and Commerce",
                    "Social Enterprise",
                    "Green Technology",
                    "Social Media",
                    "Travel and Leisure"]
    
    var localeData = ["Select closest major market",
        "Alabama (Birmingham)",
        "Alaska (Anchorage)",
        "Arizona (Phoenix, Tucson)",
        "Arkansas (Little Rock)",
        "California (LA, SF, Riverside, SD, Sacramento, San Jose, Fresno)", //DOES NOT FIT
        "Colorado (Denver)",
        "Connecticut (Bridgeport,Hartford )",
        "Delaware (Wilmington)",
        "Florida (Jacksonville, Miami, Orlando, Tampa)", //DOES NOT FIT
        "Georgia (Atlanta)",
        "Hawaii (Urban Honolulu)",
        "Idaho (Boise)",
        "Illinois (Chicago)",
        "Indiana (Indianaplis)",
        "Iowa (Des Moines)",
        "Kansas (Wichita)",
        "Kentucky (Loisville)",
        "Louisiana (New Orleans)",
        "Maine (Portland)",
        "Maryland (Baltimore)",
        "Massachusetts (Boston, Worcester)",
        "Michigan (Detroit, Grand Rapids)",
        "Minnesota (Minneapolis)",
        "Mississippi (Jackson)",
        "Missouri (Kansas City, St. Louis)",
        "Montana (Billings)",
        "Nebraska (Omaha)",
        "Nevada (Las Vegas)",
        "New Hampshire (Manchester)",
        "New Jersey (Newark)",
        "New Mexico (Albuquerque)",
        "New York (Buffalo, New York, Rochester)", //DOES NOT FIT
        "North Carolina (Charlotte, Raleigh)",
        "North Dakota (Fargo)",
        "Ohio (Cincinnati, Cleveland, Colombus)", //DOES NOT FIT WHEN IN FOCUS
        "Oklahoma (Oklahoma City, Tulsa)",
        "Oregon (Portland)",
        "Pennsylvania (Philadelphia, Pittsburgh)", //DOES NOT FIT WHEN IN FOCUS
        "Rhode Island (Providence)",
        "South Carolina (Columbia)",
        "South Dakota (Sioux Falls)",
        "Tennessee (Memphis, Nashville)",
        "Texas (Austin, Dallas, Houston, San Antonio)", //DOES NOT FIT
        "Utah (Salt Lake City)",
        "Vermont (Burlington)",
        "Virginia (Richmond, Virginia Beach)",
        "Washington (Seattle)",
        "West Virginia (Charleston)",
        "Wisconsin (Milwaukee)",
        "Wyoming (Cheyenee)",
        "Washinton D.C."]
    
    var localeDictionary: [String: Array<String>] = [
        "AL": ["Birmingham"],
        "AK": ["Anchorage"],
        "AZ": ["Phoenix", "Tucson"],
        "AR": ["Little Rock"],
        "CA": ["Los Angeles", "San Francisco", "Riverside", "San Diego", "Sacramento", "San Jose", "Fresno"], //DOES NOT FIT
        "CO": ["Denver"],
        "CT": ["Bridgeport, Hartford"],
        "DE": ["Wilmington"],
        "FL": ["Jacksonville", "Miami", "Orlando", "Tampa"], //DOES NOT FIT
        "GA": ["Atlanta"],
        "HI": ["Urban Honolulu"],
        "ID": ["Boise"],
        "IL": ["Chicago"],
        "IN": ["Indianapolis"],
        "IA": ["Des Moines"],
        "KA": ["Wichita"],
        "KY": ["Louisville"],
        "LA": ["New Orleans"],
        "ME": ["Portland"],
        "MD": ["Baltimore"],
        "MA": ["Boston", "Worcester"],
        "MI": ["Detroit", "Grand Rapids"],
        "MN": ["Minneapolis"],
        "MS": ["Jackson"],
        "MO": ["Kansas City", "St. Louis"],
        "MT": ["Billings"],
        "NE": ["Omaha"],
        "NV": ["Las Vegas"],
        "NH": ["Manchester"],
        "NJ": ["Newark"],
        "NM": ["Albuquerque"],
        "NY": ["Buffalo", "New York", "Rochester"], //DOES NOT FIT
        "NC": ["Charlotte", "Raleigh"],
        "ND": ["Fargo"],
        "OH": ["Cincinnati", "Cleveland", "Columbus"], //DOES NOT FIT WHEN IN FOCUS
        "OK": ["Oklahoma City", "Tulsa"],
        "OR": ["Portland"],
        "PA": ["Philadelphia", "Pittsburgh"], //DOES NOT FIT WHEN IN FOCUS
        "RI": ["Providence"],
        "SC": ["Columbia"],
        "SD": ["Sioux Falls"],
        "TN": ["Memphis", "Nashville"],
        "TX": ["Austin", "Dallas", "Houston", "San Antonio"], //DOES NOT FIT
        "UT": ["Salt Lake City"],
        "VT": ["Burlington"],
        "VA": ["Richmond", "Virginia Beach"],
        "WA": ["Seattle"],
        "WV": ["Charleston"],
        "WI": ["Milwaukee"],
        "WY": ["Cheyenne"],
        "Washington D.C.": ["Washington D.C."]
    ]


    var fundData = ["Not yet begun to raise capital", //NONE OF THESE FIT
                "Currently seeking to raise capital",
                "Seeking to raise additional capital"]

    var capData = ["Under $200K",
                "$200K - $500K",
                "$500K - $1 million",
                "$1 - $2 million",
                "$2 - $5 million",
                "Over $5 million"]

    var indPickerController: InputPickerController!
    var locPickerController: MultipleInputPickerController!
    var fundPickerController: InputPickerController!
    var capPickerController: InputPickerController!

    //Passed on from Credentials Page
    var companyProfile: NSManagedObject?

    //Called as the first method once this view has been set to be displayed
    override func viewDidLoad() {
        super.viewDidLoad()

        //Make sure error label is hidden
        ErrorLabel.hidden = true

        //Create a toolbar that will be shown with picker views to dismiss the view
        var toolBar: UIToolbar = UIToolbar()
        var doneButton: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Done, target: self, action: "doneButton")
        var flexSpaceLeft = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        var flexSpaceRight = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        toolBar.barStyle = UIBarStyle.Default
        toolBar.backgroundColor = .whiteColor()
        toolBar.barTintColor = .whiteColor()
        toolBar.translucent = true
        toolBar.sizeToFit()
        
        toolBar.setItems([flexSpaceLeft, doneButton, flexSpaceRight], animated: false)
        toolBar.userInteractionEnabled = true
        
        //Set up the industry picker that will be displayed when the industry field is touched
        indPickerController = InputPickerController(tfield: Industry, inputData: industryData)
        industryPicker = UIPickerView()
        industryPicker?.backgroundColor = .whiteColor()
        industryPicker?.delegate = indPickerController
        industryPicker?.dataSource = indPickerController
        
        Industry.inputView = industryPicker //setting the industry picker as the input view causes the picker to be shown
        Industry.inputAccessoryView = toolBar
        Industry.delegate = self
        
        //same thing for the locale field
        //locPickerController = InputPickerController(tfield: Locale, inputData: localeData)
        localePicker = UIPickerView()
        localePicker?.backgroundColor = .whiteColor()
        locPickerController = MultipleInputPickerController(pview: localePicker!, tfield: Locale, inputData: localeDictionary)
        localePicker?.delegate = locPickerController
        localePicker?.dataSource = locPickerController
        Locale.inputView = localePicker
        Locale.inputAccessoryView = toolBar
        Locale.delegate = self
        
        //and another for the Fundraising status
        fundPickerController = InputPickerController(tfield: Fundraising, inputData: fundData)
        fundPicker = UIPickerView()
        fundPicker?.backgroundColor = .whiteColor()
        fundPicker?.delegate = fundPickerController
        fundPicker?.dataSource = fundPickerController
        Fundraising.inputView = fundPicker
        Fundraising.inputAccessoryView = toolBar
        Fundraising.delegate = self
        
        //lastly for the Capital Goal
        capPickerController = InputPickerController(tfield: CapitalGoal, inputData: capData)
        capPicker = UIPickerView()
        capPicker?.backgroundColor = .whiteColor()
        capPicker?.delegate = capPickerController
        capPicker?.dataSource = capPickerController
        CapitalGoal.inputView = capPicker
        CapitalGoal.inputAccessoryView = toolBar
        CapitalGoal.delegate = self
        
        
    }
    
    //TextView
    func textView(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool{
        return false
    }
    
    //TextField Functionality to alow user touch input but no editing
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool{
        return false
    }
    
    func doneButton(){
        Industry.resignFirstResponder() //Dismisses the picker views if shown
        Locale.resignFirstResponder()
        Fundraising.resignFirstResponder()
        CapitalGoal.resignFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        
        //Check to make sure we are transitioning to the next signup screen
        if (identifier == "InitialSettingsViewController"){
            //If we are going to next sign up screen, let's validate the data and if good then preform segue
            if(validateFields()){
                return true
            } else{
                return false
            }
        } else {
            return true
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let initialSettings = segue.destinationViewController as? InitialSettingsViewController{
            
            //set values
            companyProfile?.setValue(Industry.text, forKey: "industry")
            companyProfile?.setValue(Locale.text, forKey: "locale")
            companyProfile?.setValue(Fundraising.text, forKey: "fundraising")
            companyProfile?.setValue(CapitalGoal.text, forKey: "capital_goal")
            
            //pass on companyProfile
            initialSettings.companyProfile = companyProfile
            
        }
    }
    
    func validateFields() -> Bool{
        var retValue:Bool = true
        var errorMsg = ""
        
        if(Industry.text?.isEmpty == true){
            errorMsg = "Make sure you selected an industry"
            
            ErrorLabel.hidden = false
            ErrorLabel.text? = errorMsg
            
            retValue = false
        } else if(Locale.text?.isEmpty == true){
            errorMsg = "Make sure you selected the closest major market"
            
            ErrorLabel.hidden = false
            ErrorLabel.text? = errorMsg
            
            retValue = false
        }
        
        return retValue
    }

}