//
//  TeamDetailViewController.swift
//  Euro 2016
//
//  Created by lhvan on 5/1/18.
//  Copyright © 2018 lhvan. All rights reserved.
//

import UIKit

class TeamDetailViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "France"
        
        tableView.dataSource = self
        
        let nib = UINib(nibName: "MatchTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "matchCell")
    }
    
}

extension TeamDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "matchCell") as! MatchTableViewCell
        cell.initCell(team1: "France", team2: "Romania", goalTeam1: 0, goalTeam2: 0)
        return cell
    }
}












