//
//  MainCoordinator.swift
//  MovieChallenge
//
//  Created by Matthew Corry on 6/4/2023.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {

        var navigationController = UINavigationController()
        func start() {
            let vc = Home(coordinator: self)
            navigationController.pushViewController(vc, animated: true)
        }
        func goToHomePage() {
            let vc = Home(coordinator: self)
            navigationController.viewControllers = [vc]
        }
        func goToDetailsPage(data: [movieViewModel]) {
            let vc = DetailsPage(coordinator: self)
            vc.data0 = data
            navigationController.pushViewController(vc, animated: true)
        }
        func goToFavourites() {
            let vc = Favourites(coordinator: self)
            navigationController.pushViewController(vc, animated: true)
        }
        func modifyData(title: String) {
            let nc = NotificationCenter.default
            nc.post(name: Notification.Name("ModifyData"), object: nil, userInfo: ["modify" : title])
        }
}
