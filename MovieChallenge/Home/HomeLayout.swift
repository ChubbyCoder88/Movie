//
//  HomeLayout.swift
//  MovieChallenge
//
//  Created by Matthew Corry on 6/4/2023.
//

import Foundation
import UIKit

extension Home {
    @objc func setUpView() {
    view.addSubview(SearchWhiteBackground)
    self.SearchWhiteBackground.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
    self.SearchWhiteBackground.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive = true
    self.SearchWhiteBackground.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20).isActive = true
    self.SearchWhiteBackground.heightAnchor.constraint(equalToConstant: 50).isActive = true
    
    view.addSubview(searchImage)
    self.searchImage.centerYAnchor.constraint(equalTo: self.SearchWhiteBackground.centerYAnchor, constant: 0).isActive = true
    self.searchImage.leftAnchor.constraint(equalTo: self.SearchWhiteBackground.leftAnchor, constant: 20).isActive = true
    self.searchImage.widthAnchor.constraint(equalToConstant: 25).isActive = true
    self.searchImage.heightAnchor.constraint(equalToConstant: 25).isActive = true
    
    view.addSubview(xForsearchImage)
    xForsearchImage.centerYAnchor.constraint(equalTo: SearchWhiteBackground.centerYAnchor, constant: 0).isActive = true
    xForsearchImage.rightAnchor.constraint(equalTo: SearchWhiteBackground.rightAnchor, constant: -10).isActive = true
    xForsearchImage.widthAnchor.constraint(equalToConstant: 35).isActive = true
    xForsearchImage.heightAnchor.constraint(equalToConstant: 35).isActive = true
    
    view.addSubview(generalTextField)
    self.generalTextField.centerYAnchor.constraint(equalTo: self.SearchWhiteBackground.centerYAnchor, constant: 3).isActive = true
    self.generalTextField.leftAnchor.constraint(equalTo: self.searchImage.rightAnchor, constant: 20).isActive = true
    self.generalTextField.rightAnchor.constraint(equalTo: self.xForsearchImage.leftAnchor, constant: -10).isActive = true
    self.generalTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
     
    self.view.addSubview(self.tableView)
    tableView.topAnchor.constraint(equalTo: SearchWhiteBackground.bottomAnchor, constant: 5).isActive = true
    tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
    tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
    tableViewBottomAnchor?.isActive = false
    tableViewBottomAnchor = tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
    tableViewBottomAnchor?.isActive = true
        
    view.addSubview(noResultsLabel)
    self.noResultsLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
    self.noResultsLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
    self.noResultsLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    @objc func modifyLayout(int: Int) {
         tableViewBottomAnchor?.isActive = false
         tableViewBottomAnchor = tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: CGFloat(int))
         tableViewBottomAnchor?.isActive = true
     }
}
