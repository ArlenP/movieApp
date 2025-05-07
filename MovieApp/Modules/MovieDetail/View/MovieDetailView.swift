//
//  MovieDetailView.swift
//  MovieApp
//
//  Created by Arlen Peña on 06/05/25.
//

import SwiftUI
struct MovieDetailView: View {
    @StateObject var presenter: MovieDetailPresenter
    var movieID: Int

    var body: some View {
        ScrollView {
            if let movie = presenter.movieDetail {
                VStack(alignment: .leading, spacing: 20) {
                    Text(movie.title)
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    Text(movie.overview)
                        .font(.body)

                    if let releaseDate = movie.releaseDate {
                        Text("Release Date: \(releaseDate)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }

                    if let posterPath = movie.posterPath {
                        if #available(iOS 15.0, *) {
                            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")) { image in
                                image.resizable()
                                    .scaledToFit()
                            } placeholder: {
                                ProgressView()
                            }
                        } else {
                            // Fallback on earlier versions
                        }
                    }
                }
                .padding()
            } else if let errorMessage = presenter.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            } else {
                ProgressView("Cargando...")
            }
        }
        .onAppear {
            Task {
                await presenter.fetchMovieDetail(id: movieID)
            }
        }
    }
}
