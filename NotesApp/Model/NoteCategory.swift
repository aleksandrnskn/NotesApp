//
//  NoteCategory.swift
//  NotesApp
//
//  Created by Aleksandr Aniskin on 21.04.2024.
//

import SwiftUI
import SwiftData

@Model
class NoteCategory {
    var categoryTitle: String
    @Relationship(deleteRule: .cascade, inverse: \Note.category)
    var note: [Note]?
    
    init(categoryTitle: String) {
        self.categoryTitle = categoryTitle
    }
}

