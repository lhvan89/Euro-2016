//
//  MatchTableViewCell.swift
//  Euro 2016
//
//  Created by lhvan on 5/1/18.
//  Copyright © 2018 lhvan. All rights reserved.
//

import UIKit

class MatchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var flag1: UIImageView!
    @IBOutlet weak var flag2: UIImageView!
    @IBOutlet weak var name1: UILabel!
    @IBOutlet weak var name2: UILabel!
    @IBOutlet weak var goals: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initCell(team1: String, team2: String, goalTeam1: Int, goalTeam2: Int){
        flag1.image = UIImage(named: team1)
        flag2.image = UIImage(named: team2)
        name1.text = team1
        name2.text = team2
        goals.text = "\(goalTeam1) - \(goalTeam2)"
    }
}











