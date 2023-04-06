//
//  FavouritesTableView.swift
//  MovieChallenge
//
//  Created by Matthew Corry on 6/4/2023.
//

import Foundation
import UIKit
import Combine

extension Favourites {
    func setUpTableViewDetails() {
        tableView.delegate      =   self
        tableView.dataSource    =   self
        tableView.register(FavouritesCell.self, forCellReuseIdentifier: FaveCellID)
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
    }
}

extension Favourites: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var info = favData0[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: FaveCellID, for: indexPath) as! FavouritesCell
        cell.VC = self
        cell.data = info
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.myBackgroundColor
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var info = favData0[indexPath.row]
        self.mainCor.goToDetailsPage(data: [info])
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favData0.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
