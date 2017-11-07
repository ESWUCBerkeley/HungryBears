//
//  SignupViewController.swift
//  esw-food-app
//
//  Created by Alexandria Finley on 11/16/16.
//  Copyright © 2016 ESWBerkeley. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignupViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmPasswordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signupButtonPressed(sender: UIButton!) {
        let email = emailField.text!
        let password1 = passwordField.text!
        let password2 = confirmPasswordField.text!
        if password1 != password2 {
            self.showErrorAlert(title: "Passwords do not match", msg: "Both password fields must match.")
        } else if !email.hasSuffix("@berkeley.edu") {
            self.showErrorAlert(title: "Invalid email", msg: "You must sign up with an official UC Berkeley email (ending in \"@berkeley.edu\").")
        } else {
            FIRAuth.auth()?.createUser(withEmail: email, password: password1) { (user, error) in
                if error != nil {
                    if error?.localizedDescription == "FIRAuthErrorCodeEmailAlreadyInUse" {
                        self.showErrorAlert(title: "Email already in use", msg: "You have already made an account.")
                    } else if error?.localizedDescription == "FIRAuthErrorCodeInvalidEmail" {
                        self.showErrorAlert(title: "Invalid email", msg: "Please enter a valid email.")
                    } else {
                        self.showErrorAlert(title: "Error", msg: "Could not sign up due to the following error: " + error!.localizedDescription)
                    }
                } else {
                    user!.sendEmailVerification()
                    self.showErrorAlert(title: "Email Verification", msg: "Please check your email to activate your account.")
                }
            }
        }
    }
    
    @IBAction func haveAccountPressed(sender: UIButton!) {
        self.performSegue(withIdentifier: SEGUE_LOGIN, sender: nil)
    }
    
    func showErrorAlert(title: String, msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }


}
