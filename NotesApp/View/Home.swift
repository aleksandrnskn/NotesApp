//
//  Home.swift
//  NotesApp
//
//  Created by Aleksandr Aniskin on 21.04.2024.
//

import SwiftUI

struct Home: View {
    /// List Selection (Going to use this as a Tab to filter the selected category notes)
    @State private var selectedTag: String?
    var body: some View {
        NavigationSplitView {
            List(selection: $selectedTag) {
                Text("All Notes")
                    .tag("All Notes")
                Text("Favourites")
                    .tag("Favourites")
            }
        } detail: {
            
        }
        .navigationTitle(selectedTag ?? "Notes")
    }
}

#Preview {
    ContentView()
}
