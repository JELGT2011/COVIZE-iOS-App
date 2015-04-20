//
//  EventTableCell.swift
//  Pitch Events
//
//  Created by Cameron Jones on 4/19/15.
//  Copyright (c) 2015 Covize. All rights reserved.
//

import Foundation

class EventTableCell: UITableViewCell{
    
    @IBOutlet weak var Title: UILabel!
    @IBOutlet weak var Organization: UILabel!
    @IBOutlet weak var FavoriteButton: UIButton!
    
    @IBOutlet weak var Logo: UIImageView!
    @IBOutlet weak var Location: UILabel!
    @IBOutlet weak var Dates: UILabel!
    @IBOutlet weak var RegistrationDeadline: UILabel!
    @IBOutlet weak var RegistrationButton: UIButton!
   
}