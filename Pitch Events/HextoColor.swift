//
//  HextoColor.swift
//  Pitch Events
//
//  Created by Austin Delk on 4/19/15.
//  Copyright (c) 2015 Covize. All rights reserved.
//

import Foundation

class HextoColor {
    
    class func uicolorFromHex(rgbValue:UInt32)->UIColor{
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:1.0)
    }
}