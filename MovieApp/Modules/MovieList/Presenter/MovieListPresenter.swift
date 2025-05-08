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
    @Published var selectedCategory: MovieCategory = .popular {
        didSet {
            Task {
                await fetchMovies(for: selectedCategory)
            }
        }
    }
    private let interactor: MovieListInteractor

    init(interactor: MovieListInteractor) {
        self.interactor = interactor
        Task {
            await fetchMovies(for: selectedCategory)
        }
    }

    func fetchMovies(for category: MovieCategory) async {
        do {
            let movies = try await interactor.fetchMovies(endpoint: category.endpoint)
            self.movies = movies
            self.errorMessage = nil
        } catch {
            self.errorMessage = "Hubo un error al obtener las películas."
            self.movies = []
        }
    }
    func genreNames(for movie: Movie) -> String {
        movie.genres?.map { $0.name }.joined(separator: ", ") ?? "N/A"
    }
}

