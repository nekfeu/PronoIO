//
//  DoneMatchController.swift
//  PronoIO
//
//  Created by Adrien MISSIOUX on 29/07/2016.
//  Copyright © 2016 Kevin Empociello. All rights reserved.
//

import UIKit
import Firebase

class DoneMatchController: UIViewController, UITableViewDataSource, UITableViewDelegate  {

    @IBOutlet var listView: UITableView!
    
    var pronos = [Prono]()
    var foldKey = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDoneMatches()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadDoneMatches() {
        var userEmail = String()
        
        if let user = FIRAuth.auth()?.currentUser {
            userEmail = user.email!
        }
        var ref = FIRDatabase.database().reference()
        
        ref.child("users").queryOrderedByKey().observeEventType(.ChildAdded, withBlock: {
            snapshot in
            
            let email = snapshot.value!["email"] as! String
            if (email == userEmail) {
                
                self.foldKey = snapshot.key
                let findMref = ref.child("users").child(self.foldKey).child("pronos").queryOrderedByKey().observeEventType(.ChildAdded, withBlock: {
                    snapshot in
                    if let tmpDictionary = snapshot.value as? Dictionary<String, AnyObject> {
                        let newProno = Prono(key: snapshot.key as String, dictionary: tmpDictionary)
                        self.pronos.append(newProno)
                        self.listView.reloadData()
                    }
                    }, withCancelBlock: { error in
                        print(error.description)
                })
            }
        })
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier("DoneMatchTableViewCell") as? DoneMatchTableViewCell {
            if (pronos[indexPath.row].dom != "0" && pronos[indexPath.row].ext != "0") {
                cell.team1.text = pronos[indexPath.row].dom
                cell.team2.text = pronos[indexPath.row].ext
                cell.pronoTeam1.text = String(pronos[indexPath.row].prono1)
                cell.pronoTeam2.text = String(pronos[indexPath.row].prono2)
                cell.logo1.image = UIImage(named: "\(pronos[indexPath.row].dom.stringByReplacingOccurrencesOfString("É", withString: "E")).png")
                cell.logo2.image = UIImage(named: "\(pronos[indexPath.row].ext.stringByReplacingOccurrencesOfString("É", withString: "E")).png")
            return cell
            }
            else {
                return UITableViewCell()
            }
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pronos.count
    }
}
