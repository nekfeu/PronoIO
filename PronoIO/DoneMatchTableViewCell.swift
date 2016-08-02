//
//  DoneMatchTableViewCell.swift
//  PronoIO
//
//  Created by Adrien MISSIOUX on 29/07/2016.
//  Copyright © 2016 Kevin Empociello. All rights reserved.
//

import UIKit

class DoneMatchTableViewCell: UITableViewCell {
    
    @IBOutlet var team1: UILabel!
    @IBOutlet var team2: UILabel!
    @IBOutlet var logo1: UIImageView!
    @IBOutlet var logo2: UIImageView!
    @IBOutlet var pronoTeam1: UILabel!
    @IBOutlet var pronoTeam2: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
