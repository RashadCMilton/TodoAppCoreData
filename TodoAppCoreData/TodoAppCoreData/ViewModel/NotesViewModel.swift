//
//  NotesViewModel.swift
//  TodoAppCoreData
//
//  Created by Rashad Milton on 3/11/25.
//

import Foundation
import CoreData

// MARK: - ViewModel
class NotesViewModel: ObservableObject {
    @Published var notes: [NoteModel] = []
    private let coreDataManager = CoreDataManager.shared
    
    init() {
        fetchNotes()
    }
    
    func fetchNotes() {
        let request: NSFetchRequest<Note> = Note.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "updatedAt", ascending: false)
        request.sortDescriptors = [sortDescriptor]
        
        do {
            let fetchedNotes = try coreDataManager.context.fetch(request)
            self.notes = fetchedNotes.map { NoteModel(note: $0) }
        } catch {
            print("Error fetching notes: \(error)")
        }
    }
    
    func addNote(title: String, content: String) {
        let newNote = Note(context: coreDataManager.context)
        newNote.id = UUID()
        newNote.title = title
        newNote.content = content
        newNote.createdAt = Date()
        newNote.updatedAt = Date()
        
        coreDataManager.saveContext()
        fetchNotes()
    }
    
    func updateNote(id: UUID, title: String, content: String) {
        let request: NSFetchRequest<Note> = Note.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        do {
            let results = try coreDataManager.context.fetch(request)
            if let noteToUpdate = results.first {
                noteToUpdate.title = title
                noteToUpdate.content = content
                noteToUpdate.updatedAt = Date()
                
                coreDataManager.saveContext()
                fetchNotes()
            }
        } catch {
            print("Error updating note: \(error)")
        }
    }
    
    func deleteNote(id: UUID) {
        let request: NSFetchRequest<Note> = Note.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        do {
            let results = try coreDataManager.context.fetch(request)
            if let noteToDelete = results.first {
                coreDataManager.context.delete(noteToDelete)
                coreDataManager.saveContext()
                fetchNotes()
            }
        } catch {
            print("Error deleting note: \(error)")
        }
    }
}
