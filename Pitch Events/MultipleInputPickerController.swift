//
//  MultipleInputPickerController.swift
//  Pitch Events
//
//  Created by Austin Delk on 4/21/15.
//  Copyright (c) 2015 Covize. All rights reserved.
//

import Foundation

class MultipleInputPickerController: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
    var pickerView: UIPickerView
    var textField: UITextField
    var dictionary: [String: [String]]
    var keys: [String]
    var selectedRow: Int
    
    init(pview: UIPickerView, tfield: UITextField, inputData: [String: Array<String>]){
        self.pickerView = pview
        textField = tfield
        dictionary = inputData //set Dictionary
        keys = Array(dictionary.keys).sorted(<)//Need an array of the dictionaries key values so that we can index that, and then retreive the cities
        selectedRow = 0
    }
    
    //Picker Funtionality
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(component == 0){
            return keys.count //if first component then set to the number of states
        } else {
            return dictionary[keys[selectedRow]]!.count //default the second number of rows to the cities in the first state
        }
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        if(component == 0){
            return keys[row]
        } else{
            let values = dictionary[keys[selectedRow]]
            return values![row] //return the city name
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //Set text to the selection
        //If the row was in the State section then we need to get which state index and set selected row to that so the right city data is grabbed, then update the table
        if(component == 0){
            selectedRow = row
            //Also set the textView to the new state and first city option
            var values = dictionary[keys[row]]
            textField.text = "\(values![0]), \(keys[row])"
            self.pickerView.reloadAllComponents()
        } else {
            //the city was selected, just set the textView to new info
            var values = dictionary[keys[selectedRow]]
            textField.text = "\(values![row]), \(keys[selectedRow])"
        }
        
        //var selectBool: Bool = (dictionary[row] != "Select closest match")  && (data[row] != "Select closest major market") //checks to see if the prompt is selected
        //textField?.text = selectBool ? data[row] : textField?.text //if a prompt is selected then keep text same, otherwise set to new selection
    }
    
}