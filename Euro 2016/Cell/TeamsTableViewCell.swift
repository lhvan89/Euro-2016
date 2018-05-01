//
//  TeamsTableViewCell.swift
//  Euro 2016
//
//  Created by lhvan on 5/1/18.
//  Copyright © 2018 lhvan. All rights reserved.
//

import UIKit

class TeamsTableViewCell: UITableViewCell {

    @IBOutlet weak var banner: UIImageView!
    @IBOutlet weak var flag: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var point: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
