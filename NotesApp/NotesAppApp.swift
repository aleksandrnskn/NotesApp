//
//  NotesAppApp.swift
//  NotesApp
//
//  Created by Aleksandr Aniskin on 21.04.2024.
//

import SwiftUI
import SwiftData

@main
struct NotesAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                /// Setting Min Frame
                .frame(minWidth: 450, minHeight: 400)
        }
        .windowResizability(.contentSize)
        /// Adding Datamodel  to the app
        .modelContainer(for: [Note.self, NoteCategory.self])
    }
}
