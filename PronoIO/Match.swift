//
//  Match.swift
//  PronoIO
//
//  Created by Kevin Empociello on 15/07/16.
//  Copyright © 2016 Kevin Empociello. All rights reserved.
//

import Firebase

class Match {
    private var ref: FIRDatabase!
    private(set) var key: String!
    private(set) var dom: String!
    private(set) var ext: String!
    private(set) var time: String!
    
    init(key: String, dictionary: Dictionary<String, AnyObject>) {
        self.key = key
        
        if let tmpDom = dictionary["localTeam"] as? String {
            self.dom = tmpDom
        }
        if let tmpExt = dictionary["extTeam"] as? String {
            self.ext = tmpExt
        }
        if let tmpTime = dictionary["time"] as? String {
            self.time = tmpTime
        }
    }
}

class Prono {
    private var ref: FIRDatabase!
    private(set) var key: String!
    private(set) var dom: String!
    private(set) var ext: String!
    private(set) var prono1: Int!
    private(set) var prono2: Int!
    private(set) var joker: String!
    
    init(key: String, dictionary: Dictionary<String, AnyObject>) {
        self.key = key
        
        if let team1 = dictionary["equipe1"] as? String {
            self.dom = team1
        }
        if let team2 = dictionary["equipe2"] as? String {
            self.ext = team2
        }
        if let pronoTeam1 = dictionary["prDom"] as? Int {
            self.prono1 = pronoTeam1
        }
        if let pronoTeam2 = dictionary["prExt"] as? Int {
            self.prono2 = pronoTeam2
        }
        if let jokerSelected = dictionary["joker"] as? String {
            self.joker = jokerSelected
        }
    }
}
