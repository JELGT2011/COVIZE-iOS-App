//
//  GeneralInfoViewController.swift
//  Pitch Events
//
//  Created by Cameron Jones on 3/31/15.
//  Copyright (c) 2015 Covize. All rights reserved.
//

import Foundation
import CoreData

class GeneralInfoViewController: UIViewController{
    
    
    @IBOutlet weak var PersonalName: UITextField!
    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var CompanyName: UITextField!
    @IBOutlet weak var ErrorLabel: UILabel!
    
    
    //Called as the first method once this view has been set to be displayed
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //make sure the error message is initially hidden and set to empty string
        ErrorLabel.hidden = true
        ErrorLabel.text? = ""
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        
        //Check to make sure we are transitioning to the next signup screen
        if (identifier == "CompanyInfoViewController"){
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
        if let companyInfo = segue.destinationViewController as? CompanyInfoViewController{
            let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
            let managedContext = appDelegate.managedObjectContext!
            
            let entity = NSEntityDescription.entityForName("CompanyProfile", inManagedObjectContext: managedContext)
            let CompanyProfile = NSManagedObject(entity: entity!, insertIntoManagedObjectContext:managedContext)
            
            //pass on company name, industry, and locale
            CompanyProfile.setValue(PersonalName.text, forKey: "name")
            CompanyProfile.setValue(Email.text, forKey: "email")
            CompanyProfile.setValue(CompanyName.text, forKey:"company_name")
            
            companyInfo.CompanyProfile = CompanyProfile
            
        }
    }
    
    //Called when a touch is registered, We use this to dismiss the keyboard when the background is clicked
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        var touch: AnyObject? = touches.anyObject()
        
        //end editing of the text input, and then take focus off of the textfield
        PersonalName.endEditing(true)
        PersonalName.resignFirstResponder()
        Email.endEditing(true)
        Email.resignFirstResponder()
        CompanyName.endEditing(true)
        CompanyName.resignFirstResponder() 
    }

    
    //Validates the user entered fields before segue
    func validateFields() -> Bool {
        //Here we need to check that all fields aren't blank, and specifics for each
        var errorMsg = "" //message we will display if fields aren't correct
        var retValue = true
        
        //Validate name: "First Last"
        if(PersonalName.text?.isEmpty == true){
            errorMsg += "Please check that you provided your name ex. John Smith\n"
            
            ErrorLabel.hidden = false // show error msg
            ErrorLabel.text? = errorMsg //append what was wrong
            
            retValue = false
        }else if(!isValidEmail(Email.text)){
            errorMsg += "Oops, you might have misstyped your email\n"
            
            ErrorLabel.hidden = false // show error msg
            ErrorLabel.text? = errorMsg //append what was wrong
            
            retValue = false
        }else if(CompanyName.text?.isEmpty == true){
            errorMsg = "Please check that you provided a company name\n"
            
            ErrorLabel.hidden = false // show error msg
            ErrorLabel.text? = errorMsg //append what was wrong
            
            retValue = false
        }
        
        //Check for black entries, then check to confirm they are same
        
        
        return retValue
    }
    
    //Checks for valide email format, including blank entry
    func isValidEmail(email:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        
        if let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx) {
            return emailTest.evaluateWithObject(email)
        }
        return false
    }
}