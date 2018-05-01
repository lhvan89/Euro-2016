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

    @IBOutlet weak var tableView: UITableView!
    
    var groupName = ["A","B","C","D","E","F"]
    
    var dataList2: [String: [Team]] = [String: [Team]]()
    
    var dataList: [[String: [Team]]] = [[String: [Team]]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        let nibName = UINib(nibName: "TeamsTableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "teamCell")
    }
    
    func loadData(){
        
        let database = Database.database().reference()
        database.child("Groups").observe(.value) { (snap) in
            self.dataList.removeAll()
            
            guard let list = snap.value as? [String: AnyObject] else { return }
            let sortList = list.sorted { $0.0 < $1.0 }
            
            for (groupName, teams) in sortList {
                
                var teamList = [Team]()
                
                guard let teamData = teams as? [String: AnyObject] else { continue }
                let sortTeam = teamData.sorted { $0.0 < $1.0 }
                
                for (teamName, teamInfo) in sortTeam {
                    
                    guard let teamPoint = teamInfo["Point"] as? Int else { continue }
                    guard let teamRank = teamInfo["Rank"] as? Int else { continue }
                    
                    teamList.append(Team(name: teamName, point: teamPoint, rank: teamRank))
                }
                self.dataList.append([groupName : teamList])
            }
            self.tableView.reloadData()
        }
    }
}

extension TeamsViewController:UITableViewDataSource {
    
    // Number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view: UIView = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 50))
        
        let imageview = UIImageView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 50))
        imageview.image = #imageLiteral(resourceName: "board")
        view.addSubview(imageview)
        
        let lable = UILabel(frame: CGRect(x: 20, y: 0, width: screenWidth, height: 50))
        lable.text = "Bảng \(groupName[section])"
        lable.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        lable.font = UIFont(name: "Arial", size: 25.0)
        view.addSubview(lable)
        return view
    }
    
    // Number of rows in section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let key = groupName[section]
        return dataList[section][key]!.count
    }
    
    // Cell for row at indexPath
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "teamCell") as! TeamsTableViewCell
        
        let key = groupName[indexPath.section] // get key at indexPath (A)
        let team = dataList[indexPath.section][key]![indexPath.row] // get team of key in data list
        
        cell.banner.image = UIImage(named: "Banner-\(team.name)")
        cell.flag.image = UIImage(named: team.name)
        cell.name.text = team.name
        
        cell.point.text = "Điểm \(team.point)"
        
        return cell
    }
}

extension TeamsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Section: \(indexPath.section)")
        print("Row: \(indexPath.row)")
    }
}
