//
//  Model.swift
//  MovieChallenge
//
//  Created by Matthew Corry on 6/4/2023.
//

import Foundation

struct moviesStruct:Codable {
    var page: Int?
    var results: [moviesDetails?]
}

struct moviesDetails:Codable {
    var title: String?
    var release_date: String?
    var poster_path: String?
    var overview: String?
    var vote_average: Double?
    var backdrop_path: String?
    var vote_count: Int?
}
