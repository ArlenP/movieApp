//
//  MovieListView
//  MovieApp
//
//  Created by Arlen Peña on 06/05/25.
//
import SwiftUI

struct MovieListView: View {
    @StateObject var presenter: MovieListPresenter
    @State private var selectedCategory: MovieCategory = .popular

    var body: some View {
        NavigationView {
            if #available(iOS 15.0, *) {
                VStack {
                    Picker("Categoría", selection: $selectedCategory) {
                        ForEach(MovieCategory.allCases) { category in
                            Text(category.rawValue).tag(category)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal)
                    
                    if #available(iOS 15.0, *) {
                        if presenter.movies.isEmpty {
                            ProgressView("Cargando películas...")
                                .onAppear {
                                    Task {
                                        await presenter.fetchMovies(for: selectedCategory)
                                    }
                                }
                        } else {
                            List(presenter.movies) { movie in
                                NavigationLink(destination: MovieDetailView(
                                    presenter: MovieDetailPresenter(interactor: MovieDetailInteractor(apiClient: APIClient())),
                                    movieID: movie.id)
                                ) {
                                    Text(movie.title)
                                }
                            }
                            .listStyle(PlainListStyle())
                            .refreshable {
                                await presenter.fetchMovies(for: selectedCategory)
                            }
                        }
                    } else {
                        // Fallback on earlier versions
                        Text("Actualiza a iOS 15 o superior para usar esta función.")
                    }
                }
                .navigationTitle("Películas")
                .onChange(of: selectedCategory) { newCategory in
                    Task {
                        await presenter.fetchMovies(for: newCategory)
                    }
                }
                .alert("Error", isPresented: .constant(presenter.errorMessage != nil), actions: {
                    Button("OK") {}
                }, message: {
                    Text(presenter.errorMessage ?? "")
                })
            } else {
                // Fallback on earlier versions
            }
        }
    }
}
