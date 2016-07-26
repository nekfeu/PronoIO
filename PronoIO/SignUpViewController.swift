//
//  SignUpViewController.swift
//  PronoIO
//
//  Created by Adrien MISSIOUX on 15/07/2016.
//  Copyright © 2016 Kevin Empociello. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {
 
    @IBOutlet var emailAddressTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var confirmPassword: UITextField!
    @IBOutlet var pseudo: UITextField!
    
    var ref = FIRDatabase.database().reference().child("/users")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.hidden=false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func CreateAccountAction(sender: AnyObject) {

        if ((emailAddressTextField.text != "" && passwordTextField != "" && confirmPassword != "") && confirmPassword.text == passwordTextField.text) {

            FIRAuth.auth()?.createUserWithEmail(emailAddressTextField.text!, password: passwordTextField.text!, completion: {
                user, error in
                if error != nil {
                    
                    print(error)
                }
                else {
                
                    print("User created")
                    let newUser = ["club": "0", "email": self.emailAddressTextField.text!, "mobile": "0000000000", "points": 0, "pseudo": self.pseudo.text!, "rank": 0]
                    let firebaseNewUser = self.ref.childByAutoId()
                    firebaseNewUser.setValue(newUser)
                    self.performSegueWithIdentifier("GoToCo", sender: self)
                }

                })
            }
        }
        
}


