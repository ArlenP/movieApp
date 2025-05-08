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
                HStack(alignment: .top, spacing: 16) {
                 
                    if let posterPath = movie.posterPath {
                        if #available(iOS 15.0, *) {
                            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w200\(posterPath)")) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 90, height: 130)
                            .cornerRadius(8)
                        } else {
                        }
                    }

                    VStack(alignment: .leading, spacing: 8) {
                        Text(movie.title)
                            .font(.title3)
                            .fontWeight(.semibold)

                        HStack(spacing: 4) {
                            StarRatingView(rating: movie.voteAverage ?? 0.0)
                            Text(String(format: "%.1f", movie.voteAverage ?? 0.0))
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }

                        Text("\(presenter.genreNames(for: movie))")
                            .font(.subheadline)

                        Text("\(presenter.formattedRuntime(for: movie))")
                            .font(.subheadline)

                        Text("\(getYear(from: movie.releaseDate)) - \(movie.productionCountries.first?.name ?? "N/A")")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                }
                .padding()
                Divider()
              HStack {
                  VStack {
                      Text("Lenguaje")
                          .font(.caption)
                          .foregroundColor(.secondary)
                      Text(movie.originalLanguage.uppercased())
                          .font(.body)
                  }
                  .frame(minWidth: 0, maxWidth: .infinity)
                  Spacer()
                  VStack {
                      Text("Comentarios")
                          .font(.caption)
                          .foregroundColor(.secondary)
                      Text("\(movie.voteCount)")
                          .font(.body)
                  }
                  .frame(minWidth: 0, maxWidth: .infinity)
                  Spacer()
                  VStack {
                      Text("Colección")
                          .font(.caption)
                          .foregroundColor(.secondary)
                      Text(movie.belongsToCollection?.name ?? "N/A")
                          .font(.body)
                          .multilineTextAlignment(.center)
                  }
                  .frame(minWidth: 0, maxWidth: .infinity)
              }
              .padding(.horizontal, 30)
              .padding(.vertical, 8)

              Divider()
                Text("Resumen")
                Text(movie.overview)
                    .font(.body)
                    .padding(.horizontal)
                    .padding(.bottom)
            } else if let errorMessage = presenter.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            } else {
                ProgressView("Cargando...")
                    .padding()
            }
        }
        .navigationTitle("")
        .onAppear {
            Task {
                await presenter.fetchMovieDetail(id: movieID)
            }
        }
    }

    private func getYear(from dateString: String?) -> String {
        guard let date = dateString, let year = date.split(separator: "-").first else {
            return "N/A"
        }
        return String(year)
    }
}
