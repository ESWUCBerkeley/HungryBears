//
//  ForgotVC.swift
//  esw-food-app
//
//  Created by Alexandria Finley on 11/16/16.
//  Copyright © 2016 ESWBerkeley. All rights reserved.
//

import UIKit
import FirebaseAuth

class ForgotVC: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func goPressed(sender: UIButton) {
        let email = emailField.text!
        if email != "" {
            FIRAuth.auth()?.sendPasswordReset(withEmail: email) { error in
                if error != nil {
                    if error?.localizedDescription == "FIRAuthErrorCodeUserNotFound" {
                        self.showErrorAlert(title: "User not found", msg: "No user account is found with that email.")
                    }
                } else {
                    //TODO switch to a view that says email was sent
                }
            }
        } else {
            self.showErrorAlert(title: "Email required", msg: "You must enter an email to retrieve your password.")
        }
    }
    
    func showErrorAlert(title: String, msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
