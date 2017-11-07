//
//  LoginViewController.swift
//  esw-food-app
//
//  Created by Alexandria Finley on 11/14/16.
//  Copyright © 2016 ESWBerkeley. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if UserDefaults.standard.value(forKey: KEY_UID) != nil {
            self.performSegue(withIdentifier: SEGUE_LOGGED_IN, sender: nil)
        }
    }
    
    @IBAction func loginButtonPressed(sender: UIButton!) {
        let email = emailField.text!
        let password = passwordField.text!
        if email != "" && password != "" {
            if !email.hasSuffix("@berkeley.edu") {
                self.showErrorAlert(title: "Invalid email", msg: "You must log in with an official UC Berkeley email (ending in \"@berkeley.edu\").")
            } else {
                FIRAuth.auth()?.signIn(withEmail: email, password: password) {(user, error) in
                    if error != nil {
                        if error?.localizedDescription == "FIRAuthErrorCodeUserNotFound" || error?.localizedDescription == " FIRAuthErrorCodeInvalidEmail" {
                            self.showErrorAlert(title: "Invalid user credentials", msg: "Invalid email or password.")
                        } else if error?.localizedDescription == "FIRAuthErrorCodeWrongPassword" {
                            self.showErrorAlert(title: "Incorrect password", msg: "Please try again")
                        } else {
                            self.showErrorAlert(title: "Error", msg: "Could not sign up due to the following error: " + error!.localizedDescription)
                        }
                    } else {
                        self.performSegue(withIdentifier: SEGUE_LOGGED_IN, sender: nil)
                    }
                }
            }
        } else {
            self.showErrorAlert(title: "Email and Password Required", msg: "You must enter an email and a password.")
        }
    }
    
    @IBAction func signupButtonPressed(sender: UIButton!) {
        self.performSegue(withIdentifier: SEGUE_SIGNUP, sender: nil)
    }
    
    @IBAction func forgotPasswordButtonPressed(sender: UIButton!) {
        self.performSegue(withIdentifier: SEGUE_FORGOT, sender: nil)
    }
    
    func showErrorAlert(title: String, msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

}
