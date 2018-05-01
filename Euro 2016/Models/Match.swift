//
//  Match.swift
//  Euro 2016
//
//  Created by lhvan on 4/25/18.
//  Copyright © 2018 lhvan. All rights reserved.
//

import Foundation

struct Match {
    var date: Date
    var goalsTeam1: Int = 0
    var goalsTeam2: Int = 0
    var groups: String
    var team1: String
    var team2: String
    
    init?(data: [String:AnyObject]) {
        guard let team1 = data["Team 1"] as? String else { return nil }
        guard let team2 = data["Team 2"] as? String else { return nil }
        guard let groups = data["Groups"] as? String else { return nil }
        guard let dateStr = data["Date"] as? String else { return nil }
        
        self.team1 = team1
        self.team2 = team2
        self.groups = groups
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        self.date = dateFormatter.date(from: dateStr)!
        
        if let goalsTeam1 = data["Goals Team 1"] as? Int {
            self.goalsTeam1 = goalsTeam1
        }
        
        if let goalsTeam2 = data["Goals Team 1"] as? Int {
            self.goalsTeam2 = goalsTeam2
        }
    }
}
