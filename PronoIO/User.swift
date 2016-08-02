//
//  User.swift
//  PronoIO
//
//  Created by Kevin Empociello on 18/07/16.
//  Copyright © 2016 Kevin Empociello. All rights reserved.
//

import Firebase

class User {
    private var ref: FIRDatabase!
    private(set) var key: String!
    private(set) var pictureUrl: String!
    private(set) var pseudo: String!
    private(set) var rank: Int!
    private(set) var points: Int!
    
    init(key: String, dictionary: Dictionary<String, AnyObject>) {
        self.key = key
        
        if let tmpPseudo = dictionary["pseudo"] as? String {
            self.pseudo = tmpPseudo
        }
        if let tmpRank = dictionary["rank"] as? Int {
            self.rank = tmpRank
        }
        if let tmpPoints = dictionary["points"] as? Int {
            self.points = tmpPoints
        }
    }
}

