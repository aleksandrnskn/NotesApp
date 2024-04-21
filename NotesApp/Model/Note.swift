//
//  Note.swift
//  NotesApp
//
//  Created by Aleksandr Aniskin on 21.04.2024.
//

import SwiftUI
import SwiftData

@Model
class Note {
    var content: String
    var isFavorite: Bool = false
    var category: NoteCategory?
    
    init(content: String, category: NoteCategory) {
        self.content = content
        self.category = category
    }
}
