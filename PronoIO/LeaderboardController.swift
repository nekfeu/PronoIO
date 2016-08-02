//
//  LeaderboardController.swift
//  PronoIO
//
//  Created by Kevin Empociello on 18/07/16.
//  Copyright © 2016 Kevin Empociello. All rights reserved.
//

import UIKit
import Firebase

class LeaderboardController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    // Podium outlet
    @IBOutlet weak var firstPicture: UIImageView!
    @IBOutlet weak var secondPicture: UIImageView!
    @IBOutlet weak var thirdPicture: UIImageView!
    @IBOutlet weak var firstPseudo: UILabel!
    @IBOutlet weak var secondPseudo: UILabel!
    @IBOutlet weak var thirdPseudo: UILabel!
    @IBOutlet weak var firstPoints: UILabel!
    @IBOutlet weak var secondPoints: UILabel!
    @IBOutlet weak var thirdPoints: UILabel!
    
    var users = Array<User>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadLeaderboard()
    }
    
    func loadLeaderboard() {
        let scoresRef = FIRDatabase.database().reference().child("/users")
        scoresRef.queryOrderedByChild("points").observeEventType(.ChildAdded, withBlock: { snapshot in
            if let tmpDictionary = snapshot.value as? Dictionary<String, AnyObject> {
                let newUser = User(key: snapshot.key as String, dictionary: tmpDictionary)
                self.users.append(newUser)
                self.tableView.reloadData()
            }
            if let score = snapshot.value!["points"] as? Int {
                print("The \(snapshot.key) dinosaur's score is \(score)")
            }}, withCancelBlock: { error in
                print(error.description)
        })
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier("UserCellTableView") as? UserCellTableView {
            cell.pseudo.text = users[indexPath.row].pseudo
            cell.points.text = "\(users[indexPath.row].points) points"
            cell.rank.text = "\(users[indexPath.row].rank)"
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
}