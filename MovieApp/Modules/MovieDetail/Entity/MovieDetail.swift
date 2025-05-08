//
//  MovieDetail.swift
//  MovieApp
//
//  Created by Arlen Peña on 06/05/25.
//

import Foundation

struct MovieDetail: Decodable {
    let id: Int
    let title: String
    let overview: String
    let releaseDate: String?
    let posterPath: String?
    let runtime: Int?
    let genres: [Genre]?
    let voteAverage: Double?
    let voteCount: Int
    let productionCountries: [ProductionCountry]
    let originalLanguage: String
    let originCountry: [String]
    let belongsToCollection: MovieCollection?
}
struct ProductionCountry: Decodable {
    let name: String
}
struct MovieCollection: Decodable {
    let id: Int
    let name: String
    let posterPath: String?
    let backdropPath: String?
}
struct MovieVideoResponse: Decodable {
    let results: [MovieVideo]
}

struct MovieVideo: Decodable, Identifiable {
    let id: String 
    let key: String
    let name: String
    let site: String
    let type: String
}
