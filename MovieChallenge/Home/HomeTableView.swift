//
//  HomeTableView.swift
//  MovieChallenge
//
//  Created by Matthew Corry on 6/4/2023.
//

import Foundation
import UIKit
import Combine

extension Home {
    func setUpTableViewDetails() {
        tableView.delegate      =   self
        tableView.dataSource    =   self
        tableView.register(HomeCell.self, forCellReuseIdentifier: HomeCellID)
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
    }
}

extension Home: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var info = data0[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeCellID, for: indexPath) as! HomeCell
        cell.homeVC = self
        cell.data = info
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.myBackgroundColor
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var info = data0[indexPath.row]
        self.mainCor.goToDetailsPage(data: [info])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data0.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
    
 
