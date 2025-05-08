//
//  UnderlinePickerStyle.swift
//  MovieApp
//
//  Created by Arlen Peña on 07/05/25.
//

import Foundation
import SwiftUI

struct SegmentedPicker: View {
    let options: [MovieCategory]
    @Binding var selection: MovieCategory
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                ForEach(options, id: \.self) { option in
                    VStack(spacing: 4) {
                        Text(option.rawValue.capitalized)
                            .font(.subheadline)
                            .foregroundColor(selection == option ? .blue : .gray)
                        
                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(selection == option ? .blue : .clear)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            selection = option
                        }
                    }
                }
            }
        }
        .background(Color(.systemGray6))
        .cornerRadius(4)
    }
}
