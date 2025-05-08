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
            contentView
        }
        .navigationTitle("")
        .onAppear {
            Task {
                await presenter.fetchMovieDetail(id: movieID)
                await presenter.fetchMovieVideos(id: movieID)
            }
        }
    }
    
    @ViewBuilder
    private var contentView: some View {
        if let movie = presenter.movieDetail {
            movieContentView(movie: movie)
        } else if let errorMessage = presenter.errorMessage {
            errorView(message: errorMessage)
        } else {
            loadingView
        }
    }
    
    private func movieContentView(movie: MovieDetail) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            headerSection(movie: movie)
            Divider()
            infoColumnsSection(movie: movie)
            Divider()
            overviewSection(movie: movie)
            videosSection
        }
        .padding()
    }
    
    private func headerSection(movie: MovieDetail) -> some View {
        HStack(alignment: .top, spacing: 16) {
            posterImage(movie: movie)
            movieInfo(movie: movie)
            Spacer()
        }
        .padding()
    }
    
    private func posterImage(movie: MovieDetail) -> some View {
        Group {
            if let posterPath = movie.posterPath {
                if #available(iOS 15.0, *) {
                    AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w200\(posterPath)")) { phase in
                        if let image = phase.image {
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        } else if phase.error != nil {
                            Image(systemName: "film")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        } else {
                            ProgressView()
                        }
                    }
                    .frame(width: 90, height: 130)
                    .cornerRadius(8)
                } else {
                    Image(systemName: "film")
                        .frame(width: 90, height: 130)
                }
            }
        }
    }
    
    private func movieInfo(movie: MovieDetail) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(movie.title)
                .font(.title3)
                .fontWeight(.semibold)
            
            ratingView(movie: movie)
            
            Text(presenter.genreNames(for: movie))
                .font(.subheadline)
            
            Text(presenter.formattedRuntime(for: movie))
                .font(.subheadline)
            
            Text("\(getYear(from: movie.releaseDate)) - \(movie.productionCountries.first?.name ?? "N/A")")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
    
    private func ratingView(movie: MovieDetail) -> some View {
        HStack(spacing: 4) {
            StarRatingView(rating: movie.voteAverage ?? 0.0)
            Text(String(format: "%.1f", movie.voteAverage ?? 0.0))
                .font(.subheadline)
                .foregroundColor(.gray)
        }
    }
    
    private func infoColumnsSection(movie: MovieDetail) -> some View {
        HStack {
            infoColumn(title: "Lenguaje", value: movie.originalLanguage.uppercased())
            Spacer()
            infoColumn(title: "Comentarios", value: "\(movie.voteCount)")
            Spacer()
            infoColumn(title: "Colección", value: movie.belongsToCollection?.name ?? "N/A")
        }
        .padding(.horizontal, 30)
        .padding(.vertical, 8)
    }
    
    private func infoColumn(title: String, value: String) -> some View {
        VStack {
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
            Text(value)
                .font(.body)
                .multilineTextAlignment(.center)
        }
        .frame(minWidth: 0, maxWidth: .infinity)
    }
    
    private func overviewSection(movie: MovieDetail) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Resumen")
                .font(.headline)
                .fontWeight(.bold)
            
            Text(movie.overview)
                .font(.body)
        }
        .padding(.horizontal)
        .padding(.bottom)
    }
    
    @ViewBuilder
    private var videosSection: some View {
        if !(presenter.movieVideos?.isEmpty ?? false) {
            VStack(alignment: .leading) {
                Text("Videos")
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(presenter.movieVideos ?? []) { video in
                            videoThumbnail(video: video)
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .padding(.top)
        }
    }
    
    private func videoThumbnail(video: MovieVideo) -> some View {
        VStack {
            if #available(iOS 15.0, *) {
                AsyncImage(url: URL(string: "https://img.youtube.com/vi/\(video.key)/0.jpg")) { phase in
                    Group {
                        if let image = phase.image {
                            image
                                .resizable()
                                .scaledToFill()
                        } else if phase.error != nil {
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                                .padding()
                                .foregroundColor(.gray)
                        } else {
                            ProgressView()
                        }
                    }
                    .frame(width: 150, height: 120)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .contentShape(RoundedRectangle(cornerRadius: 12))
                }
            } else {
                Image(systemName: "video")
                    .frame(width: 150, height: 120)
                    .background(Color.gray.opacity(0.3))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
        }
    }
    
    private func errorView(message: String) -> some View {
        Text(message)
            .foregroundColor(.red)
            .padding()
    }
    
    private var loadingView: some View {
        ProgressView("Cargando...")
            .padding()
    }
    
    private func getYear(from dateString: String?) -> String {
        guard let date = dateString, let year = date.split(separator: "-").first else {
            return "N/A"
        }
        return String(year)
    }
}
