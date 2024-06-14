//
//  NoteDetailViewModel.swift
//  SecuredNote
//
//  Created by CHANDRA SEKARAN M on 12/06/2024.
//

import Foundation
import CoreData

@Observable
class NoteDetailViewModel {
    var note: Note
    @ObservationIgnored
    let context: NSManagedObjectContext
    
    init(note: Note, context: NSManagedObjectContext ) {
        self.note = note
        self.context = context
    }
    
    func saveNote() {
        let request = NoteManagedData.fetchRequest() as NSFetchRequest<NoteManagedData>
        request.predicate = NSPredicate(format: "noteId == %@", note.noteId as CVarArg)
        if let existingNote = try? context.fetch(request).first{
            existingNote.timestamp = Date()
            existingNote.title = note.title
            existingNote.content = note.content
        }else {
            let newNote = NoteManagedData(context: context)
            newNote.timestamp = Date()
            newNote.noteId = note.noteId
            newNote.title = note.title
            newNote.content = note.content
        }
        
        do {
            try context.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
}
