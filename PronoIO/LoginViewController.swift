//
//  LoginViewController.swift
//  PronoIO
//
//  Created by Adrien MISSIOUX on 15/07/2016.
//  Copyright © 2016 Kevin Empociello. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {

    @IBOutlet var emailAddress: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var fbButton: FBSDKLoginButton!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.hidden=true
        if (FBSDKAccessToken.currentAccessToken() != nil)
        {
            // User is already logged in, do work such as go to next view controller.
            dispatch_async(dispatch_get_main_queue()){
                self.performSegueWithIdentifier("GoToMainMenu", sender: self)
            }
        }
        else
        {
            fbButton.readPermissions = ["public_profile", "email", "user_friends"]
            fbButton.delegate = self
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Login(sender: AnyObject) {
        
        self.login(emailAddress.text!, password: password.text!)
        
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
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        print("User Logged In")
        
        if ((error) != nil)
        {
            // Process error
        }
        else if result.isCancelled {
            // Handle cancellations
        }
        else {
            if result.grantedPermissions.contains("email")
            {
                // Do work
                let credential = FIRFacebookAuthProvider.credentialWithAccessToken(FBSDKAccessToken.currentAccessToken().tokenString)
                FIRAuth.auth()?.signInWithCredential(credential) { (user, error) in
                if let user = FIRAuth.auth()?.currentUser {
                            let name = user.displayName! as String
                            let email = user.email! as String
                            let uid = user.uid
                    
                    print(email, name, uid)
                    
                    let checkWaitingRef = FIRDatabase.database().reference().child("/users")
                    checkWaitingRef.queryOrderedByChild("email").queryEqualToValue("\(email)")
                        .observeEventType(.Value, withBlock: { snapshot in
                            
                            if ( snapshot.value is NSNull ) {
                                print("not found)")
                                
                                var ref = FIRDatabase.database().reference().child("/users")
                                
                                let newUser = ["club": "0", "email": email, "mobile": "0000000000", "points": 0, "pseudo": name, "rank": 0]
                                let firebaseNewUser = ref.childByAutoId()
                                firebaseNewUser.setValue(newUser)
                                
                            } else {
                                let val = snapshot.value
                                print(snapshot.value)
                            }
                    })
                }
                else {
                        print("No user is signed in.")
                    }
                    self.performSegueWithIdentifier("GoToMainMenu", sender: self)
                }

            }
        }

    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("User Logged Out")
        
        try! FIRAuth.auth()!.signOut()
        loginButtonDidLogOut(fbButton)
    }
}
