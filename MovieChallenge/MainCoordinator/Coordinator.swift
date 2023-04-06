//
//  Coordinator.swift
//  MovieChallenge
//
//  Created by Matthew Corry on 6/4/2023.
//

import Foundation
import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get }
    func start()
}

protocol Coordinating {
    var coordinator: Coordinator? { get set }
}

