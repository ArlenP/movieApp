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
    private(set) var movieDetail: MovieDetail?
    private(set) var errorMessage: String?

    init(interactor: MovieDetailInteractorProtocol) {
        self.interactor = interactor
    }

    func fetchMovieDetail(id: Int) async {
        do {
            movieDetail = try await interactor.fetchMovieDetail(id: id)
        } catch {
            errorMessage = "Error fetching movie details"
        }
    }
}
