//
//  ConfigManager.swift
//  MovieApp
//
//  Created by Arlen Peña on 06/05/25.
//

import Foundation

protocol APIClientProtocol {
    func fetch<T: Decodable>(_ endpoint: Endpoint, type: T.Type) async throws -> T
}

class APIClient: APIClientProtocol {
    func fetch<T: Decodable>(_ endpoint: Endpoint, type: T.Type) async throws -> T {
        let request = URLRequest(url: endpoint.url)

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw APIError.invalidResponse
        }

        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(T.self, from: data)
        } catch {
            throw APIError.decodingError(error)
        }
    }
}
