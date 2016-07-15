//
//  MatchController.swift
//  PronoIO
//
//  Created by Kevin Empociello on 15/07/16.
//  Copyright © 2016 Kevin Empociello. All rights reserved.
//

import UIKit
import Firebase

class MatchController: UIViewController {
    
    func setupFirebase() {
        // Get a reference to our posts
        let ref = Firebase(url:"https://bustergoal-dc7ce.firebaseio.com/matches")
        
        // Retrieve new posts as they are added to your database
        ref.observeEventType(.ChildAdded, withBlock: { snapshot in
            print(snapshot.value.objectForKey("Team1") as! String)
            print(snapshot.value.objectForKey("Team2") as! String)
            }, withCancelBlock: { error in
                print(error.description)
        })
        print("Finish")
        print("Test")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFirebase()
    }
    
}

