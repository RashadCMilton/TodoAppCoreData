//
//  NoteListView.swift
//  TodoAppCoreData
//
//  Created by Rashad Milton on 3/11/25.
//

import SwiftUI

struct NoteListView: View {
    @StateObject private var viewModel = NotesViewModel()
    @State private var isShowingNewNoteView = false
    @State private var selectedNote: NoteModel?
    @State private var isShowingEditNoteView = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.notes) { note in
                    VStack(alignment: .leading, spacing: 8) {
                        Text(note.title)
                            .font(.headline)
                        Text(note.content)
                            .font(.subheadline)
                            .lineLimit(2)
                        Text(formatDate(note.updatedAt))
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    .padding(.vertical, 4)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        selectedNote = note
                        isShowingEditNoteView = true
                    }
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        viewModel.deleteNote(id: viewModel.notes[index].id)
                    }
                }
            }
            .navigationTitle("Notes")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isShowingNewNoteView = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $isShowingNewNoteView) {
                NoteEditorView(mode: .new, viewModel: viewModel)
            }
            .sheet(isPresented: $isShowingEditNoteView) {
                if let note = selectedNote {
                    NoteEditorView(mode: .edit(note), viewModel: viewModel)
                }
            }
        }
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}



#Preview {
    NoteListView()
}
