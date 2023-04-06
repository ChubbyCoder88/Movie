//
//  DataManager.swift
//  MovieChallenge
//
//  Created by Matthew Corry on 6/4/2023.
//

import Foundation
import Combine
import UIKit

class DataManagerGenerics {
    func apiCallGeneric<T: Codable>(url: URL, text: String) -> AnyPublisher<T, Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    func apiCallNoneGeneric(url: URL) -> AnyPublisher<moviesStruct, Error> {
       return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
           .decode(type: moviesStruct.self, decoder: JSONDecoder())
           .receive(on: RunLoop.main)
           .eraseToAnyPublisher()
       }
}
enum DataError:Error {
    case noDataAvailable
}
