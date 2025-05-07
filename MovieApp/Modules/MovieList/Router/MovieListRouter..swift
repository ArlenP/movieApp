//
//  MovieListInteractor
//  MovieApp
//
//  Created by Arlen Peña on 06/05/25.
//
import SwiftUI
@MainActor
final class MovieListRouter {
    static func createModule() -> some View {
        let interactor = MovieListInteractor()
        let presenter = MovieListPresenter(interactor: interactor)
        return MovieListView(presenter: presenter)
    }
}
