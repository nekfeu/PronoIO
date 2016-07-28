//
//  ProfilViewController.swift
//  PronoIO
//
//  Created by Adrien MISSIOUX on 24/07/2016.
//  Copyright © 2016 Kevin Empociello. All rights reserved.
//

import UIKit
import Firebase

class ProfilViewController: UIViewController {
    
   override func viewDidLoad() {
        super.viewDidLoad()

    // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func deconnexion(sender: AnyObject) {

        let alertController = UIAlertController(title: "Attention",   message: "Etes vous sur de vouloir vous déconnecter ?", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Annuler", style: UIAlertActionStyle.Default, handler: nil))
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (action: UIAlertAction!) in
            
            let loginManager = FBSDKLoginManager()
            loginManager.logOut()
            self.performSegueWithIdentifier("GoBack", sender: self)
            
            
        }))
        self.presentViewController(alertController, animated: true, completion: nil)
    }

}
