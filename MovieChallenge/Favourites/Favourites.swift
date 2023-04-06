//
//  Favourites.swift
//  MovieChallenge
//
//  Created by Matthew Corry on 6/4/2023.
//

import UIKit
var favData0 = [movieViewModel]()
class Favourites: UIViewController {
    let FaveCellID = "FaveCellID"
    var tableView = tableCustom()
    var data0 = favData0
    var mainCor: MainCoordinator
    init(coordinator: MainCoordinator) {
        self.mainCor = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.myBlue
        self.navigationController?.navigationBar.titleTextAttributes = NSAttributedString.navString
        self.navigationItem.title = "Favourites"
        setUpView()
        setUpTableViewDetails()
    }
    @objc func setUpView() {
        self.view.addSubview(self.tableView)
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
    @objc func removeFromFavourites(cell: UITableViewCell, bool: Bool) {
        guard let index = tableView.indexPath(for: cell) else { return }
        let cell = tableView.cellForRow(at: index) as! FavouritesCell
        var title = favData0[index.row].title
        favData0.remove(at: index.row)
        DispatchQueue.main.async { self.tableView.reloadData() }
        
        // update data from home page
        mainCor.modifyData(title: title)
    }
}
