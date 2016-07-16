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
 
    @IBOutlet var EmailAddressTextField: UITextField!
    @IBOutlet var PasswordTextField: UITextField!
    @IBOutlet var ConfirmPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.hidden=false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func CreateAccountAction(sender: AnyObject) {

        if ((EmailAddressTextField.text != "" && PasswordTextField != "" && ConfirmPassword != "") && ConfirmPassword.text == PasswordTextField.text) {

            FIRAuth.auth()?.createUserWithEmail(EmailAddressTextField.text!, password: PasswordTextField.text!, completion: {
                user, error in
                
                if error != nil {
                    
                    print(error)
                    
                }
                else {
                
                    print("User created")
                    
                    self.performSegueWithIdentifier("GoToCo", sender: self)
                    
                }
                
            })
            
            }
            
            
        }
        
}


