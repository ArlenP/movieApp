//
//  TestView.swift
//  MovieApp
//
//  Created by Arlen Peña on 06/05/25.
//
import SwiftUI

struct TestView: View {
    @StateObject private var viewModel = TestViewModel()

    var body: some View {
        NavigationView {
            if #available(iOS 15.0, *) {
                List(viewModel.movies) { movie in
                    VStack(alignment: .leading) {
                        Text(movie.title)
                            .font(.headline)
                        Text(movie.overview)
                            .font(.subheadline)
                            .lineLimit(2)
                    }
                }
                .navigationTitle("Películas populares")
                .onAppear {
                    Task {
                        await viewModel.fetchMovies()
                    }
                }
                .alert("Error", isPresented: .constant(viewModel.errorMessage != nil), actions: {
                    Button("OK") {}
                }, message: {
                    Text(viewModel.errorMessage ?? "")
                })
            } else {
                // Fallback on earlier versions
            }
        }
    }
}

#Preview {
    TestView()
}
