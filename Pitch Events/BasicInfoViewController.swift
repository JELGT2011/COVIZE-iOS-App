//
//  BasicInfoViewController.swift
//  Pitch Events
//
//  Created by Austin Delk on 4/3/15.
//  Copyright (c) 2015 Covize. All rights reserved.
//

import Foundation

class BasicInfoViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var CompanyName: UITextField!
    @IBOutlet weak var Industry: UITextField!
    @IBOutlet weak var Locale: UITextField!
    @IBOutlet weak var ErrorLabel: UILabel!
    
    
    var industryPicker: UIPickerView?
    var localePicker: UIPickerView?
    var industryData = ["Select the Closest Match", "Technology", "Other"]
    var localeData = ["Atlanta, GA", "Houston, Tx"]
    var indPickerController: InputPickerController!
    var locPickerController: InputPickerController!
    
    //Passed on from Credentials Page
    var PersonalName:String = ""
    var Email:String = ""
    var Password:String = ""
    
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
        
    }

    //Handles the dismissing of the keyboard when background is touched
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        var touch: AnyObject? = touches.anyObject()
        if ((touch?.view != industryPicker) || (touch?.view != localePicker)){
            Industry.resignFirstResponder()
            Locale.resignFirstResponder()
        }
        
        CompanyName.endEditing(true)
        CompanyName.resignFirstResponder()

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
        if (identifier == "InitialFiltersViewController"){
            ErrorLabel.hidden = false // show error msg
            ErrorLabel.text? = ""
            
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
        if let initialFilters = segue.destinationViewController as? InitialFiltersViewController{
            //pass on name, email, and password
            
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    func validateFields() -> Bool{
        var retValue:Bool = true
        var errorMsg = ""
        
        if(CompanyName.text?.isEmpty == true){
            errorMsg = "Please check that you provided a company name\n"
            
            ErrorLabel.hidden = false // show error msg
            ErrorLabel.text? = errorMsg //append what was wrong
            
            retValue = false
        } else if(Industry.text?.isEmpty == true){
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