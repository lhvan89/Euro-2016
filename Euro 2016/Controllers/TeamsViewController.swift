//
//  ViewController.swift
//  Euro 2016
//
//  Created by lhvan on 4/25/18.
//  Copyright © 2018 lhvan. All rights reserved.
//

import UIKit
import Firebase

class TeamsViewController: UIViewController {
    
//    var ref: DatabaseReference!
    
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var dataList: [String: [Team]] = [
        "A": [
            Team(name: "VietNam", point: 0, rank: 0),
            Team(name: "Lao", point: 0, rank: 0),
            Team(name: "Malay", point: 0, rank: 0),
            Team(name: "Singapore", point: 0, rank: 0)
        ],
        "B": [
            Team(name: "ThaiLan", point: 0, rank: 0),
            Team(name: "Campuchia", point: 0, rank: 0)
        ]
    ]
    
    var dataList2: [[String: [Team]]] = [[String: [Team]]]()
    
    //get list of keys (A,B,C,D)
    var orderKeys: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()

        guard let flagName = Flags["France"] else { return }
        print(flagName)
        
        tableView.dataSource = self
        
        //orderKeys = Array(dataList.keys.sorted())
        orderKeys = dataList.keys.sorted(by: { (str1, str2) -> Bool in
            return str1 < str2
        })
    }
    
    func loadData(){
        let database = Database.database().reference()
        database.child("Groups").observe(.value) { (snap) in
            if let list = snap.value as? [String: AnyObject] {
                let sortLits = list.sorted() {$0.0 < $1.0}
                
                for (groupName, teams) in sortLits {
                    var teamList = [Team]()
                    if let teamData = teams as? [String: [String: AnyObject]] {
                        for (teamName, teamInfo) in teamData {
                            guard let teamPoint = teamInfo["Point"] as? Int else { continue }
                            guard let teamRank = teamInfo["Rank"] as? Int else { continue }
                            let team = Team(name: teamName, point: teamPoint, rank: teamRank)
                            teamList.append(team)
                        }
                    }
                    if teamList.count > 0 {
                        var groupAndTeam = ["Bảng \(groupName)" : teamList]
                        self.dataList2.append(groupAndTeam)
                    }
                }
                print(self.dataList2)
                print(self.dataList2.count)
            }
            
        }
    }
}

extension TeamsViewController:UITableViewDataSource {
    
    // Number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataList2.count
    }
    
    // Title for header in section
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return orderKeys[section]
    }
    
    // Number of rows in section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let key = orderKeys[section]
        return dataList[key]!.count
    }
    
    // Cell for row at indexPath
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "teamCell")
        
        let key = orderKeys[indexPath.section] // get key at indexPath (A)
        let team = dataList[key]![indexPath.row] // get team of key in data list
        
        cell?.textLabel?.text = team.name
        
        return cell!
    }
}
