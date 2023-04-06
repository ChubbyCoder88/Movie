//
//  DetailsPageTableView.swift
//  MovieChallenge
//
//  Created by Matthew Corry on 6/4/2023.
//

import Foundation
import UIKit
import Combine

extension DetailsPage {
    func setUpTableViewDetails() {
        tableView.delegate      =   self
        tableView.dataSource    =   self
        tableView.register(DetailsCell.self, forCellReuseIdentifier: DetailsCellID)
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
    }
}

extension DetailsPage: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var info = data0[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailsCellID, for: indexPath) as! DetailsCell
        cell.data = info
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.myBackgroundColor
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data0.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 900
    }
}
