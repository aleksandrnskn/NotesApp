//
//  Home.swift
//  NotesApp
//
//  Created by Aleksandr Aniskin on 21.04.2024.
//

import SwiftUI
import SwiftData

struct Home: View {
    /// List Selection (Going to use this as a Tab to filter the selected category notes)
    @State private var selectedTag: String? = "All Notes"
    /// Quering All Categories
    @Query(animation: .snappy) private var categories: [NoteCategory]
    /// Model Context
    @Environment(\.modelContext) private var context
    /// View Properties
    @State private var addCategory: Bool = false
    @State private var categoryTitle: String = ""
    @State private var requestedCategory: NoteCategory?
    @State private var deleteRequest: Bool = false
    @State private var renameRequest: Bool = false
    /// Dark Mode Toggle
    @State private var isDark: Bool = true
    var body: some View {
        NavigationSplitView {
            List(selection: $selectedTag) {
                Text("All Notes")
                    .tag("All Notes")
                    .foregroundStyle(selectedTag == "All Notes" ? Color.primary : .gray)
                Text("Favourites")
                    .tag("Favourites")
                    .foregroundStyle(selectedTag == "Favourites" ? Color.primary : .gray)
                
                /// User Created Categories
                Section {
                    ForEach(categories) { category in
                        Text(category.categoryTitle)
                            .tag(category.categoryTitle)
                            .foregroundStyle(selectedTag == category.categoryTitle ? Color.primary : .gray)
                            /// Some basic Editing Options
                            .contextMenu {
                                Button("Rename") {
                                    ///Placing the Already Having title in the TextField
                                    categoryTitle = category.categoryTitle
                                    requestedCategory = category
                                    renameRequest = true
                                }
                                Button("Delete") {
                                    categoryTitle = category.categoryTitle
                                    requestedCategory = category
                                    deleteRequest = true
                                }
                            }
                    }
                } header: {
                    HStack(spacing: 5) {
                        Text("Categories")
                        Button("", systemImage: "plus") {
                            addCategory.toggle()
                        }
                        .tint(.gray)
                        .buttonStyle(.plain)
                    }
                }
            }
        } detail: {
            
        }
        .navigationTitle(selectedTag ?? "Notes")
        /// Adding Category Alert
        .alert("Add category", isPresented: $addCategory) {
            TextField("Category title", text: $categoryTitle)
            Button("Cancel", role: .cancel) {
                categoryTitle = ""
            }
            Button("Add") {
                /// Adding New Category to Swift Data
                let category = NoteCategory(categoryTitle: categoryTitle)
                context.insert(category)
                categoryTitle = ""
            }
        }
        /// Rename Alert
        .alert("Rename category", isPresented: $renameRequest) {
            TextField("Work", text: $categoryTitle)
            Button("Cancel", role: .cancel) {
                categoryTitle = ""
                requestedCategory = nil
            }
            Button("Rename") {
                if let requestedCategory {
                    requestedCategory.categoryTitle = categoryTitle
                    categoryTitle = ""
                    self.requestedCategory = nil
                }
                categoryTitle = ""
            }
        }
        /// Delete Alert
        .alert("Are you sure to delete \(categoryTitle) category?", isPresented: $deleteRequest) {
            Button("NO", role: .cancel) {
                categoryTitle = ""
                requestedCategory = nil
            }
            Button("YES", role: .destructive) {
                if let requestedCategory {
                    context.delete(requestedCategory)
                    categoryTitle = ""
                    self.requestedCategory = nil
                }
                categoryTitle = ""
            }
        }
        /// Tool Bar Items
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                HStack(spacing: 10) {
                    Button("", systemImage: "plus") {
                        /// Adding New Note
                    }
                    Button("", systemImage: isDark ? "sun.min" : "moon") {
                        /// Dark – Light Mode
                        isDark.toggle()
                    }
                }
            }
        }
        .preferredColorScheme(isDark ? .dark : .light)
    }
}

#Preview {
    ContentView()
}
