//
//  MovieDetailPresenter.swift
//  MovieApp
//
//  Created by Arlen Peña on 06/05/25.
//

import Foundation

import SwiftUI

@MainActor
class MovieDetailPresenter: ObservableObject {
    private let interactor: MovieDetailInteractorProtocol
    @Published var movieDetail: MovieDetail?
    @Published var movieVideos: [MovieVideo]?
    @Published var errorMessage: String?
    @Published var videoUrls: [String] = []
    
    init(interactor: MovieDetailInteractorProtocol) {
        self.interactor = interactor
    }

    func fetchMovieDetail(id: Int) async {
        do {
            movieDetail = try await interactor.fetchMovieDetail(id: id)
            print("Movie detail loaded: \(String(movieDetail!.id) ?? "Sin título")")
            try await fetchMovieVideos(id: id)
        } catch {
            errorMessage = "Error fetching movie details"
        }
    }
    
    func genreNames(for movie: MovieDetail) -> String {
        movie.genres?.map { $0.name }.joined(separator: ", ") ?? "N/A"
    }
    
    func formattedRuntime(for movie: MovieDetail) -> String {
        guard let runtime = movie.runtime else { return "Duración: N/A" }
        let hours = runtime / 60
        let minutes = runtime % 60
        return "\(hours)h \(minutes)min"
    }
    
    func fetchMovieVideos(id: Int) async {
        do {
            let movieVideos = try await interactor.fetchMovieVideos(id: id)
            print("Videos recibidos: \(movieVideos.count)")
            self.movieVideos = movieVideos
            self.videoUrls = movieVideos.map { "https://www.youtube.com/watch?v=\($0.key)"}
            
        } catch {
            self.errorMessage = "Error al obtener los videos: \(error.localizedDescription)"
        }
    }
}
