//
//  Item.swift
//  NotesApp
//
//  Created by Aleksandr Aniskin on 21.04.2024.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
