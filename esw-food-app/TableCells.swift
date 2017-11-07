//
//  TableCells.swift
//  esw-food-app
//
//  Created by Kristina Laue on 12/27/16.
//  Copyright © 2016 ESWBerkeley. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import Photos

class TableCells: UITableViewCell {
    @IBOutlet weak var foodType: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var servingsLeft: UILabel!
    @IBOutlet weak var timeLeft: UILabel!
    @IBOutlet weak var foodImage: UIImageView!
    
}
