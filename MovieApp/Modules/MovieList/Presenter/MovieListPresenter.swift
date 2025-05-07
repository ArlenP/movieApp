//
//  MovieListInteractor
//  MovieApp
//
//  Created by Arlen Peña on 06/05/25.
//
import Foundation

@MainActor
class MovieListPresenter: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var errorMessage: String?

    private let interactor: MovieListInteractor

    init(interactor: MovieListInteractor) {
        self.interactor = interactor
    }

    func onAppear() {
        fetchMovies()
    }

    func fetchMovies() {
        Task {
            do {
                let movies = try await interactor.fetchMovies()
                self.movies = movies
            } catch {
                self.errorMessage = "Hubo un error al obtener las películas."
            }
        }
    }
}
