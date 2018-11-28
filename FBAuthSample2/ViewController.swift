//
//  ViewController.swift
//  FBAuthSample2
//
//  Created by Equinox on 19/11/2561 BE.
//  Copyright © 2561 Equinox. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    
    @IBOutlet weak var Fieldemail: UITextField!
    @IBOutlet weak var Fieldpass: UITextField!
    @IBOutlet weak var FieldFname: UITextField!
    @IBOutlet weak var FieldLname: UITextField!
    @IBOutlet weak var FieldAge: UITextField!
    @IBOutlet weak var RegisBTN: UIButton!
    @IBOutlet weak var ClearBTN: UIButton!
    
    var databaseRefer : DatabaseReference!
    var databaseHandle : DatabaseHandle!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        RegisBTN.layer.cornerRadius = 0.07 * RegisBTN.bounds.size.width
        ClearBTN.layer.cornerRadius = 0.07 * ClearBTN.bounds.size.width
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    @IBAction func RegisterAction(_ sender: Any) {
        let email = Fieldemail.text!
        let pass = Fieldpass.text!
        let Fname = FieldFname.text!
        let Lname = FieldLname.text!
        let Age = FieldAge.text!
        
        if (!email.isEmpty && !pass.isEmpty && !Fname.isEmpty && !Lname.isEmpty && !Age.isEmpty) {
            Auth.auth().createUser(withEmail: email, password: pass) { (user,error) in
               
                if(user != nil){
                    
                    let uid = Auth.auth().currentUser?.uid
                    
                    self.databaseRefer = Database.database().reference()
                    self.databaseRefer.child("users").child(uid!).setValue(["First Name":Fname,"Last Name":Lname,"Age":Age])
                    
                    
                    print(uid!)
                    print("Create User Success !!!")
                }
                else{
                    if let myError = error?.localizedDescription{
                        print(myError)
                        if(myError == "The email is already in use !"){
                            print("Email is invalid")
                        }else{
                            print("Error Check your code")
                        }
                    }
                }
            }
            
        }
        
    }
    
    
    @IBAction func ClearAction(_ sender: Any) {
        Fieldemail.text = ""
        Fieldpass.text = ""
        FieldFname.text = ""
        FieldLname.text = ""
        FieldAge.text = ""
    }
    
}

