//
//  ConfigManager.swift
//  MovieApp
//
//  Created by Arlen Peña on 06/05/25.
//

import Foundation

enum APIError: Error {
    case invalidResponse
    case decodingError(Error)
    case unknown
}
