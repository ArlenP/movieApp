//
//  Movie.swift
//  MovieApp
//
//  Created by Arlen Peña on 06/05/25.
//

import Foundation

struct MovieResponse: Decodable {
    let results: [Movie]
}
struct Movie: Decodable, Identifiable {
    let id: Int
    let title: String
    let overview: String
    let releaseDate: String?
    let posterPath: String?
    let voteAverage: Double?
    let genreIds: [Int]?

    var runtime: Int? = nil
    var genres: [Genre]? = nil
}
struct Genre: Decodable, Identifiable {
    let id: Int
    let name: String
}
