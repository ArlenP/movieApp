//
//  File.swift
//  MovieApp
//
//  Created by Arlen Peña on 07/05/25.
//

import Foundation
enum MovieCategory: String, CaseIterable, Identifiable {
    case popular = "Populares"
    case nowPlaying = "Recientes"
    case topRated = "Recomendadas"

    var id: String { self.rawValue }

    var endpoint: Endpoint {
        switch self {
        case .popular: return .popularMovies
        case .nowPlaying: return .nowPlaying
        case .topRated: return .topRated
        }
    }
}
