//
//  StarRatingView.swift
//  MovieApp
//
//  Created by Arlen Peña on 07/05/25.
//

import SwiftUI

struct StarRatingView: View {
    let rating: Double
    let maxRating = 5

    var body: some View {
        HStack(spacing: 2) {
            ForEach(0..<maxRating, id: \.self) { index in
                Image(systemName: index < Int(rating / 2) ? "star.fill" : "star")
                    .foregroundColor(.yellow)
            }
        }
    }
}
