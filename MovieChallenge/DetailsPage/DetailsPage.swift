//
//  DetailsPage.swift
//  MovieChallenge
//
//  Created by Matthew Corry on 6/4/2023.
//

import UIKit

class DetailsPage: UIViewController {
    
    let DetailsCellID = "DetailsCellID"
    var tableView = tableCustom()
    var data0 = [movieViewModel]()
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
        self.navigationItem.title = "Details"
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
}
