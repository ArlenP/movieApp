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
    @Published var errorMessage: String?
    
    init(interactor: MovieDetailInteractorProtocol) {
        self.interactor = interactor
    }

    func fetchMovieDetail(id: Int) async {
        do {
            movieDetail = try await interactor.fetchMovieDetail(id: id)
            print("Movie detail loaded: \(movieDetail?.title ?? "Sin título")")
        } catch {
            errorMessage = "Error fetching movie details"
        }
    }
}
