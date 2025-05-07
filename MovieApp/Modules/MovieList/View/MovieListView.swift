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
                List(presenter.movies) { movie in
                    NavigationLink(destination: MovieDetailView(
                        presenter: MovieDetailPresenter(interactor: MovieDetailInteractor(apiClient: APIClient())),
                        movieID: movie.id)
                    ) {
                        Text(movie.title)
                    }
                }
                .navigationTitle("Listado de Películas")
                .onAppear {
                    presenter.onAppear()
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
