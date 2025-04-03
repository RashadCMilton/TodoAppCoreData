//
//  NoteEditorView.swift
//  TodoAppCoreData
//
//  Created by Rashad Milton on 3/11/25.
//
import Foundation
import SwiftUI

// Note Editor View (Screen 2)
enum NoteEditorMode {
    case new
    case edit(NoteModel)
}

struct NoteEditorView: View {
    let mode: NoteEditorMode
    let viewModel: NotesViewModel
    
    @State private var title: String = ""
    @State private var content: String = ""
    @Environment(\.presentationMode) var presentationMode
    
    init(mode: NoteEditorMode, viewModel: NotesViewModel) {
        self.mode = mode
        self.viewModel = viewModel
        
        switch mode {
        case .new:
            _title = State(initialValue: "")
            _content = State(initialValue: "")
        case .edit(let note):
            _title = State(initialValue: note.title)
            _content = State(initialValue: note.content)
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $title)
                
                ZStack(alignment: .topLeading) {
                    if content.isEmpty {
                        Text("Note content...")
                            .foregroundColor(.gray)
                            .padding(.top, 8)
                            .padding(.leading, 5)
                    }
                    TextEditor(text: $content)
                        .frame(minHeight: 200)
                }
            }
            .navigationTitle(mode.isNewNote ? "New Note" : "Edit Note")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        saveNote()
                        presentationMode.wrappedValue.dismiss()
                    }
                    .disabled(title.isEmpty)
                }
            }
        }
    }
    
    private func saveNote() {
        switch mode {
        case .new:
            viewModel.addNote(title: title, content: content)
        case .edit(let note):
            viewModel.updateNote(id: note.id, title: title, content: content)
        }
    }
}

extension NoteEditorMode {
    var isNewNote: Bool {
        switch self {
        case .new: return true
        case .edit: return false
        }
    }
}

#Preview {
    NoteEditorView(mode: .new, viewModel: NotesViewModel())
}
