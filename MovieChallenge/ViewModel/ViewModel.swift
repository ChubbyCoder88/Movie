//
//  ViewModel.swift
//  MovieChallenge
//
//  Created by Matthew Corry on 6/4/2023.
//

import Foundation

struct movieViewModel:Codable, Equatable {
    var title: String
    var release_date: String?
    var poster_image: String?
    var overview: String?
    var vote_average: String?
    var backdrop_image: String?
    var vote_count: String?
    var isFavourite: Bool
}
