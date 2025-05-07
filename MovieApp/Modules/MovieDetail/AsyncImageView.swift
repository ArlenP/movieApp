//
//  AsyncImageView.swift
//  MovieApp
//
//  Created by Arlen Peña on 06/05/25.
//

import Foundation
import SwiftUI

struct AsyncImageView: View {
    let url: String
    @State private var imageData: Data? = nil
    
    var body: some View {
        Group {
            if let imageData, let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 375)
            } else {
                ProgressView()
                    .onAppear {
                        loadImage()
                    }
            }
        }
    }

    private func loadImage() {
        guard let imageURL = URL(string: url) else { return }
        URLSession.shared.dataTask(with: imageURL) { data, _, _ in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.imageData = data
            }
        }.resume()
    }
}
