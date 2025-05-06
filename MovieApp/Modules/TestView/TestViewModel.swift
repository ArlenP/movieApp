
//
//  Movie.swift
//  MovieApp
//
//  Created by Arlen Peña on 06/05/25.
//
import Foundation

@MainActor
class TestViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var errorMessage: String?

    private let apiClient: APIClientProtocol = APIClient()

    func fetchMovies() async {
        do {
            let response = try await apiClient.fetch(.popularMovies, type: MovieResponse.self)
            movies = response.results
        } catch {
            errorMessage = "Error al cargar películas: \(error.localizedDescription)"
        }
    }
}
