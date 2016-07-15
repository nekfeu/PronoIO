//
//  LoginViewController.swift
//  PronoIO
//
//  Created by Adrien MISSIOUX on 15/07/2016.
//  Copyright © 2016 Kevin Empociello. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet var EmailAddress: UITextField!
    @IBOutlet var Password: UITextField!
   
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.hidden=true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Login(sender: AnyObject) {
        
        self.login(EmailAddress.text!, password: Password.text!)
        
    }

    func login(email: String, password: String) {
        
        FIRAuth.auth()?.signInWithEmail(email, password: password, completion: {
            user, error in
            
            if (error != nil) {
                
                print("Error")
            }
            else {
                
                print("Ca marche plutot bien ouais !")
                self.performSegueWithIdentifier("GoToMainMenu", sender: self)
            }
        })
    }
    
}
