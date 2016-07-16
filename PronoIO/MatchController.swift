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
    
    func getMatchFromAPI() {
        var matches: NSArray = NSArray()
        let ref = FIRDatabase.database().reference().child("/matches")
        
        if let path = NSBundle.mainBundle().pathForResource("ligue1", ofType: "json") {
            if let jsonData = try? NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe) {
                if let jsonResult: NSDictionary = (try? NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers)) as? NSDictionary {
                    if let tmp : NSArray = jsonResult["matches"] as? NSArray {
                        matches = tmp
                        // Do stuff
                    }
                    
                    for elem in matches {
                        
                        var tmpWeek = "week"
                        tmpWeek += elem.valueForKey("week") as! String
                        let weekRef = ref.child("/\(tmpWeek)")
                        let newMatchRef = weekRef.childByAutoId()
                        
                        let match = ["localTeam" : elem.valueForKey("localteam_name") as! String, "extTeam": elem.valueForKey("visitorteam_name") as! String, "formatted_date" : elem.valueForKey("formatted_date") as! String, "time": elem.valueForKey("time") as! String, "status": elem.valueForKey("status") as! String, "score": "0-0", "week": elem.valueForKey("week") as! String]
                        
                        newMatchRef.setValue(match)
                        usleep(400)
                    }
                }
            }
        }
    }
    
    func loadMatches() {
        let ref = FIRDatabase.database().reference().child("/matches/week1")
        
        ref.observeEventType(.ChildAdded, withBlock: { snapshot in
            if let tmpDictionary = snapshot.value as? Dictionary<String, AnyObject> {
                let newMatch = Match(key: snapshot.key as String, dictionary: tmpDictionary)
                self.matches.append(newMatch)
                self.tableView.reloadData()
            }
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
        if let cell = tableView.dequeueReusableCellWithIdentifier("MatchCellTableView") as? MatchCellTableView {
            cell.dom.text = matches[indexPath.row].dom
            cell.ext.text = matches[indexPath.row].ext
            cell.hour.text = matches[indexPath.row].time
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matches.count
    }
    
}

