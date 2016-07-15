//
//  Match.swift
//  PronoIO
//
//  Created by Kevin Empociello on 15/07/16.
//  Copyright © 2016 Kevin Empociello. All rights reserved.
//

import Firebase

class Match {
    private var ref: Firebase!
    private(set) var key: String!
    private(set) var dom: String!
    private(set) var ext: String!
    private(set) var date: String!
    
    init(key: String, dictionary: Dictionary<String, AnyObject>) {
        self.key = key
        
        if let tmpDom = dictionary["dom"] as? String {
            self.dom = tmpDom
        }
        if let tmpExt = dictionary["ext"] as? String {
            self.ext = tmpExt
        }
        if let tmpDate = dictionary["date"] as? String {
            self.date = tmpDate
        }
    }
}
