//
//  MovieListInteractor
//  MovieApp
//
//  Created by Arlen Peña on 06/05/25.
//
import Foundation

class MovieListInteractor {
    private let apiClient: APIClientProtocol

    init(apiClient: APIClientProtocol = APIClient()) {
        self.apiClient = apiClient
    }

    func fetchMovies(endpoint: Endpoint) async throws -> [Movie] {
        let response: MovieResponse = try await apiClient.fetch(endpoint, type: MovieResponse.self)
        return response.results
    }
}
