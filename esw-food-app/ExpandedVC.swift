//
//  ExpandedVC.swift
//  esw-food-app
//
//  Created by Kristina Laue on 1/2/17.
//  Copyright © 2017 ESWBerkeley. All rights reserved.
//
import UIKit
import FirebaseDatabase

class ExpandedVC: UIViewController {

    @IBOutlet weak var foodType: UILabel!
    @IBOutlet weak var servingsLeft: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var timeLeft: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        foodType.text = mainInstance.foodType
        location.text = mainInstance.location
        servingsLeft.text = mainInstance.servingsLeft
        timeLeft.text = mainInstance.timeLeft
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }
    

    
}
