//
//  MovieDetailInteractor.swift
//  MovieApp
//
//  Created by Arlen Peña on 06/05/25.
//

import Foundation

protocol MovieDetailInteractorProtocol {
    func fetchMovieDetail(id: Int) async throws -> MovieDetail
}

class MovieDetailInteractor: MovieDetailInteractorProtocol {
    private let apiClient: APIClientProtocol

    init(apiClient: APIClientProtocol = APIClient()) {
        self.apiClient = apiClient
    }

    func fetchMovieDetail(id: Int) async throws -> MovieDetail {
        let endpoint = Endpoint.movieDetail(id: id)
        return try await apiClient.fetch(endpoint, type: MovieDetail.self)
    }
}
