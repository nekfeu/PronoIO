//
//  PronosticViewController.swift
//  PronoIO
//
//  Created by Adrien MISSIOUX on 26/07/2016.
//  Copyright © 2016 Kevin Empociello. All rights reserved.
//

import UIKit
import Firebase

class PronosticViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet var equipe1: UILabel!
    @IBOutlet var equipe2: UILabel!
    @IBOutlet var time: UILabel!
    @IBOutlet var logoEquipe1: UIImageView!
    @IBOutlet var logoEquipe2: UIImageView!
    @IBOutlet var score1: UILabel!
    @IBOutlet var score2: UILabel!
    @IBOutlet var jokersSelected: UITextField!
    
    var equipe1_name = String()
    var equipe2_name = String()
    var matchTime = String()
    
    var data = ["FIFA:", "Empo", "<", "Missio"]
    var picker = UIPickerView()
    
    var checkP = false
    var foldKey = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.hidden=false
        picker.delegate = self
        picker.dataSource = self
        jokersSelected.inputView = picker
        picker.showsSelectionIndicator = true
        picker.delegate = self
        picker.dataSource = self
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.Default
        toolBar.translucent = true
        toolBar.tintColor = UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 1)
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: "donePicker")
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "donePicker")
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.userInteractionEnabled = true
        jokersSelected.inputView = picker
        jokersSelected.inputAccessoryView = toolBar
        self.equipe1.text = self.equipe1_name
        self.equipe2.text = self.equipe2_name
        self.time.text = self.matchTime
        self.logoEquipe1.image = UIImage(named: "\(self.equipe1_name.stringByReplacingOccurrencesOfString("É", withString: "E")).png")
        self.logoEquipe2.image = UIImage(named: "\(self.equipe2_name.stringByReplacingOccurrencesOfString("É", withString: "E")).png")
        checkUserProno()
    }
    
    func donePicker() {
        
        jokersSelected.resignFirstResponder()
        
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        jokersSelected.text = data[row]
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data[row]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func up1(sender: AnyObject) {
        var scoreEquipe1 = Int(self.score1.text!)!
        if scoreEquipe1 < 30{
            scoreEquipe1 += 1
        }
        self.score1.text = String(scoreEquipe1)
    }
    
    @IBAction func down1(sender: AnyObject) {
        var scoreEquipe1 = Int(self.score1.text!)!
        if scoreEquipe1 > 0{
            scoreEquipe1 -= 1
        }
        self.score1.text = String(scoreEquipe1)
    }
    
    @IBAction func up2(sender: AnyObject) {
        var scoreEquipe2 = Int(self.score2.text!)!
        if scoreEquipe2 < 30{
            scoreEquipe2 += 1
        }
        self.score2.text = String(scoreEquipe2)
    }
    
    @IBAction func down2(sender: AnyObject) {
        var scoreEquipe2 = Int(self.score2.text!)!
        if scoreEquipe2 > 0{
            scoreEquipe2 -= 1
        }
        self.score2.text = String(scoreEquipe2)
    }
    
    func checkUserProno() {
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
                    
                    let equipe1 = snapshot.value!["equipe1"] as! String
                    let equipe2 = snapshot.value!["equipe2"] as! String
                    
                    if (equipe1 == self.equipe1.text && equipe2 == self.equipe2.text) {
                        
                        self.checkP = true
                        print("yolooooooo")
                    }
                    
                })
                
            }
            
        })
        
    }
    
    @IBAction func validate(sender: AnyObject) {
        
        var ref = FIRDatabase.database().reference()
        
        print(self.checkP)
        if (self.checkP == false) {
            
            let alertController = UIAlertController(title: "Confirmation",   message: "Confirmer le pronostic ?", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Annuler", style: UIAlertActionStyle.Default, handler: nil))
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (action: UIAlertAction!) in
                
            
            let post = ["equipe1": self.equipe1.text!, "equipe2": self.equipe2.text!, "prDom": Int(self.score1.text!)!, "prExt": Int(self.score2.text!)!, "joker" : self.jokersSelected.text!]
            let newRef = ref.child("users").child(self.foldKey).child("pronos").childByAutoId()
            print(newRef)
            newRef.setValue(post)
            }))
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        else {
            let alertController = UIAlertController(title: "Vous avez déjà pronostiqué sur ce match !",   message: "Attention", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
}