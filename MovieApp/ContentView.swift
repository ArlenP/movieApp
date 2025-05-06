//
//  ContentView.swift
//  MovieApp
//
//  Created by Arlen Peña on 06/05/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            if #available(iOS 15.0, *) {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
            } else {
                // Fallback on earlier versions
            }
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
