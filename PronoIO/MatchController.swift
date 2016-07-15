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
    
    var matches = Array<Match>()
    
    func loadMatches() {
        let ref = Firebase(url:"https://bustergoal-dc7ce.firebaseio.com/matches")
        
        ref.observeEventType(.ChildAdded, withBlock: { snapshot in
            
            //var newMatch = Match("", "", "")
            print(snapshot.key as! String)
            print(snapshot.value.objectForKey("dom") as! String)
            print(snapshot.value.objectForKey("ext") as! String)
            
            }, withCancelBlock: { error in
                print(error.description)
        })
        print("Finish")
        print("Test")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMatches()
    }
    
}

