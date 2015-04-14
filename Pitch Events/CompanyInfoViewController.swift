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
    //TO-DO add all data
    var industryData = ["Select the Closest Match", "Technology", "Other"]
    var localeData = ["Atlanta, GA", "Houston, Tx"]
    var fundData = ["Just Beginning", "Completed"]
    var capData = ["nothing", "all da monies"]
    var indPickerController: InputPickerController!
    var locPickerController: InputPickerController!
    var fundPickerController: InputPickerController!
    var capPickerController: InputPickerController!
    
    //Passed on from Credentials Page
    var CompanyProfile: NSManagedObject?
    
    //Called as the first method once this view has been set to be displayed
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Make sure error label is hidden
        ErrorLabel.hidden = true
        
        //Set up the industry picker that will be displayed when the industry field is touched
        indPickerController = InputPickerController(tfield: Industry, inputData: industryData)
        industryPicker = UIPickerView()
        industryPicker?.delegate = indPickerController
        industryPicker?.dataSource = indPickerController
        
        Industry.inputView = industryPicker //setting the industry picker as the input view causes the picker to be shown
        Industry.delegate = self
        
        //same thing for the locale field
        locPickerController = InputPickerController(tfield: Locale, inputData: localeData)
        localePicker = UIPickerView()
        localePicker?.delegate = locPickerController
        localePicker?.dataSource = locPickerController
        Locale.inputView = localePicker
        Locale.delegate = self
        
        //and another for the Fundraising status
        fundPickerController = InputPickerController(tfield: Fundraising, inputData: fundData)
        fundPicker = UIPickerView()
        fundPicker?.delegate = fundPickerController
        fundPicker?.dataSource = fundPickerController
        Fundraising.inputView = fundPicker
        Fundraising.delegate = self
        
        //lastly for the Capital Goal
        capPickerController = InputPickerController(tfield: CapitalGoal, inputData: capData)
        capPicker = UIPickerView()
        capPicker?.delegate = capPickerController
        capPicker?.dataSource = capPickerController
        CapitalGoal.inputView = capPicker
        CapitalGoal.delegate = self
        
        
    }
    
    //TextField Functionality to alow user touch input but no editing
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool{
        return false
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
            //We aren't transitioning to the next sign up screen (probably cancel button was clicked), allow the transition
            return true
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // Check to see if we are transitioning to the detailed event view
        if let initialSettings = segue.destinationViewController as? InitialSettingsViewController{
            
            //set values
            CompanyProfile?.setValue(Industry.text, forKey: "industry")
            CompanyProfile?.setValue(Locale.text, forKey: "locale")
            CompanyProfile?.setValue(Fundraising.text, forKey: "fundraising")
            CompanyProfile?.setValue(CapitalGoal.text, forKey: "capital_goal")
            
            //pass on companyProfile
            initialSettings.CompanyProfile = CompanyProfile
            
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