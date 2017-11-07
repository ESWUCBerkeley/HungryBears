//
//  ViewController.swift
//  esw-food-app
//
//  Created by Kristina Laue on 12/27/16.
//  Copyright © 2016 ESWBerkeley. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import Photos


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var tableView: UITableView!
    var ref: FIRDatabaseReference!
    var messages: [FIRDataSnapshot]! = []
    fileprivate var _refHandle: FIRDatabaseHandle!
    var storageRef: FIRStorageReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDatabase()
//        self.tableView.register(TableCells.self, forCellReuseIdentifier: "TableCells")
    }
    deinit {
        self.ref.child("messages").removeObserver(withHandle: _refHandle)
    }
    func configureDatabase() {
        
        ref = FIRDatabase.database().reference()
        // Listen for new messages in the Firebase database
        _refHandle = self.ref.child("messages").observe(.childAdded, with: { [weak self] (snapshot) -> Void in
            guard let strongSelf = self else { return }
            strongSelf.messages.append(snapshot)
            strongSelf.tableView.insertRows(at: [IndexPath(row: strongSelf.messages.count-1, section: 0)], with: .automatic)
            })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Dequeue cell
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "TableCells", for: indexPath) as! TableCells
        let messageSnapshot: FIRDataSnapshot! = self.messages[indexPath.row]
        print("hahaha")
        let message = messageSnapshot.value as! Dictionary<String, String>
        if let foodtype = message["foodtype"] as String! {
            cell.foodType?.text = "Food Type: " + foodtype
        } else {
            cell.foodType?.text = "Someone forgot to put something here."

        }
        if let timeLeft = message["timeleft"] as String! {
            cell.timeLeft?.text = "Time Left: " + timeLeft
        } else {
            cell.timeLeft?.text = "Someone forgot to put something here."
        }
        if let servingsLeft = message["servingsleft"] as String! {
            cell.servingsLeft?.text = "Servings Left: " + servingsLeft
            
        } else {
            cell.servingsLeft?.text = "Someone forgot to put something here."
        }
        if let location = message["location"] as String! {
            cell.location?.text = "Location: " + location
        } else {
            cell.location?.text = "Someone forgot to put something here."
            
        }
        cell.layer.borderWidth = 1.0
        cell.layer.borderColor = UIColor.black.cgColor
        return cell
    }
    
    func tableView(_ tableView: UITableView!, didSelectRowAt indexPath: IndexPath) {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "TableCells", for: indexPath) as! TableCells
        let messageSnapshot: FIRDataSnapshot! = self.messages[indexPath.row]
        print("hahaha")
        let message = messageSnapshot.value as! Dictionary<String, String>
        if let foodtype = message["foodtype"] as String! {
            cell.foodType?.text = "Food Type: " + foodtype
        } else {
            cell.foodType?.text = "Someone forgot to put something here."
            
        }
        if let timeLeft = message["timeleft"] as String! {
            cell.timeLeft?.text = "Time Left: " + timeLeft
        } else {
            cell.timeLeft?.text = "Someone forgot to put something here."
        }
        if let servingsLeft = message["servingsleft"] as String! {
            cell.servingsLeft?.text = "Servings Left: " + servingsLeft
            
        } else {
            cell.servingsLeft?.text = "Someone forgot to put something here."
        }
        if let location = message["location"] as String! {
            cell.location?.text = "Location: " + location
        } else {
            cell.location?.text = "Someone forgot to put something here."
            
        }
        mainInstance.location = cell.location.text
        mainInstance.servingsLeft = cell.servingsLeft.text
        mainInstance.foodType = cell.foodType.text
        mainInstance.timeLeft = cell.timeLeft.text
        
        self.performSegue(withIdentifier: "getFood", sender: nil)
    }
    

    
    
    
//        override func viewDidLoad() {
//            super.viewDidLoad()
//    
//    
//            configureDatabase()
//            //        configureStorage()
//        }
//    

    

        //    func configureStorage() {
        //        let storageUrl = FIRApp.defaultApp()?.options.storageBucket
        //        storageRef = FIRStorage.storage().reference(forURL: "gs://" + storageUrl!)
        //    }


    
        //        if let imageURL = message[Constants.MessageFields.imageURL] {
        //            if imageURL.hasPrefix("gs://") {
        //                FIRStorage.storage().reference(forURL: imageURL).data(withMaxSize: INT64_MAX){ (data, error) in
        //                    if let error = error {
        //                        print("Error downloading: \(error)")
        //                        return
        //                    }
        //                    cell.imageView?.image = UIImage.init(data: data!)
        //                }
        //            } else if let URL = URL(string: imageURL), let data = try? Data(contentsOf: URL) {
        //                cell.imageView?.image = UIImage.init(data: data)
        //            }
        //            cell.textLabel?.text = "sent by: \(name)"
        //        } else {
    
    
    
        //            cell.imageView?.image = UIImage(named: "ic_account_circle")
        //            if let photoURL = message[Constants.MessageFields.photoURL], let URL = URL(string: photoURL), let data = try? Data(contentsOf: URL) {
        //                cell.imageView?.image = UIImage(data: data)
        //            }
        //        }
        
        
    }
    

