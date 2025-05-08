//
//  MovieListView
//  MovieApp
//
//  Created by Arlen Peña on 06/05/25.
//
import SwiftUI

struct MovieListView: View {
    @StateObject var presenter: MovieListPresenter

    var body: some View {
        NavigationView {
            if #available(iOS 15.0, *) {
                VStack {
                    SegmentedPicker(
                        options: MovieCategory.allCases,
                        selection: $presenter.selectedCategory
                    )
                    .padding(.horizontal)
                    .onChange(of: presenter.selectedCategory) { newCategory in
                        Task {
                            await presenter.fetchMovies(for: newCategory)
                        }
                    }
                    
                    Image(presenter.selectedCategory.headerImageName)
                        .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                            .mask(
                                RoundedRectangle(cornerRadius: 12)
                                    .frame(height: 200)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                            )
                            .shadow(radius: 3)
                            .padding(.horizontal, 8)
                    if presenter.movies.isEmpty {
                        ProgressView("Cargando películas...")
                            .onAppear {
                                Task {
                                    await presenter.fetchMovies(for: presenter.selectedCategory)
                                }
                            }
                    } else {
                        List(presenter.movies) { movie in
                            NavigationLink(destination: MovieDetailView(
                                presenter: MovieDetailPresenter(interactor: MovieDetailInteractor(apiClient: APIClient())),
                                movieID: movie.id)
                            ) {
                                HStack(spacing: 16) {
                                    if let posterPath = movie.posterPath {
                                        AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w200\(posterPath)")) { image in
                                            image.resizable()
                                        } placeholder: {
                                            ProgressView()
                                        }
                                        .frame(width: 60, height: 90)
                                        .cornerRadius(8)
                                    }

                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(movie.title)
                                            .font(.headline)

                                        Text(presenter.formattedRuntime(for: movie))
                                            .font(.subheadline)
                                            .foregroundColor(.gray)

                                        HStack(spacing: 4) {
                                            StarRatingView(rating: movie.voteAverage ?? 0.0)
                                            Text(String(format: "%.1f", movie.voteAverage ?? 0.0))
                                                .font(.subheadline)
                                                .foregroundColor(.gray)
                                        }

                                        Text("Géneros: \(presenter.genreNames(for: movie))")
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                    }
                                }
                                .padding(.vertical, 4)
                            }
                        }
                        .listStyle(PlainListStyle())
                        .refreshable {
                            await presenter.fetchMovies(for: presenter.selectedCategory)
                        }
                    }
                }
                .navigationTitle("Películas")
                .alert("Error", isPresented: .constant(presenter.errorMessage != nil), actions: {
                    Button("OK") {}
                }, message: {
                    Text(presenter.errorMessage ?? "")
                })
            } else {
                Text("Actualiza a iOS 15 o superior para usar esta función.")
            }
        }
    }
}
