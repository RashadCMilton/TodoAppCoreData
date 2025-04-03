//
//  NoteModel.swift
//  TodoAppCoreData
//
//  Created by Rashad Milton on 3/11/25.
//

import Foundation
// Note Model
struct NoteModel: Identifiable {
    let id: UUID
    var title: String
    var content: String
    let createdAt: Date
    var updatedAt: Date
    init(note: Note) {
            self.id = note.id ?? UUID()
            self.title = note.title ?? ""
            self.content = note.content ?? ""
            self.createdAt = note.createdAt ?? Date()
            self.updatedAt = note.updatedAt ?? Date()
        }
}
