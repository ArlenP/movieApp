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
    var displayName: String {
        switch self {
        case .popular: return "Populares"
        case .nowPlaying: return "Recientes"
        case .topRated: return "Recomendadas"
        }
    }

    var headerImageName: String {
        switch self {
        case .popular: return "popular_banner"
        case .nowPlaying: return "now_playing_banner"
        case .topRated: return "top_rated_banner"
        }
    }
}
