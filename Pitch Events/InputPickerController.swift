//
//  inputPickerController.swift
//  Pitch Events
//
//  Created by Cameron Jones on 4/12/15.
//  Copyright (c) 2015 Covize. All rights reserved.
//

import Foundation

class InputPickerController: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
    var textField: UITextField?
    var data: [String]
    
    init(tfield: UITextField, inputData: [String]){
        textField = tfield
        data = inputData
        
        //textField?.text = data[0] //set the initial text for the view
    }
    
    //Picker Funtionality
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return data[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //Set text to the selection
        var selectBool: Bool = (data[row] != "Select closest match")  && (data[row] != "Select closest major market") //checks to see if the prompt is selected
        textField?.text = selectBool ? data[row] : textField?.text //if a prompt is selected then keep text same, otherwise set to new selection
    }

}