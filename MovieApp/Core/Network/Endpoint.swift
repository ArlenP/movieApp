//
//  ConfigManager.swift
//  MovieApp
//
//  Created by Arlen Peña on 06/05/25.
//

import Foundation

enum Endpoint {
    case popularMovies
    case nowPlaying
    case topRated
    case movieDetail(id: Int)

    var path: String {
        switch self {
        case .popularMovies:
            return "/3/movie/popular"
        case .nowPlaying:
            return "/3/movie/now_playing"
        case .topRated:
            return "/3/movie/top_rated"
        case .movieDetail(let id):
            return "/3/movie/\(id)"
        }
    }

    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.themoviedb.org"
        components.path = path
        components.queryItems = [
            URLQueryItem(name: "api_key", value: ConfigManager.apiKey),
            URLQueryItem(name: "language", value: "es-MX")
        ]
        guard let url = components.url else {
            fatalError("URL inválida para endpoint: \(self)")
        }
        return url
    }
}
