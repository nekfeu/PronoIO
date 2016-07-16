//
//  MatchController.swift
//  PronoIO
//
//  Created by Kevin Empociello on 15/07/16.
//  Copyright © 2016 Kevin Empociello. All rights reserved.
//

import UIKit
import Firebase

class MatchController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var matches = Array<Match>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMatches()
    }
    
    func loadMatches() {
        let ref = Firebase(url:"https://bustergoal-dc7ce.firebaseio.com/matches")
        
        ref.observeEventType(.ChildAdded, withBlock: { snapshot in
            let newMatch = Match(key: snapshot.key as String, dictionary: Dictionary<String, AnyObject>())
            
            print(snapshot.key as String)
            print(snapshot.value.objectForKey("dom") as! String)
            print(snapshot.value.objectForKey("ext") as! String)
            
            self.matches.append(newMatch)
            self.tableView.reloadData()
            }, withCancelBlock: { error in
                print(error.description)
        })
        print("Finish")
        print("Test")
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matches.count
    }
    
}

