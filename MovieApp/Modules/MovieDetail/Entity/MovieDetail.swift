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
}
