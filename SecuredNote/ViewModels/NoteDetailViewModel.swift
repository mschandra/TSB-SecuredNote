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
    @ObservationIgnored
    var note: Note
    @ObservationIgnored
    let context: NSManagedObjectContext
    
    init(note: Note, context: NSManagedObjectContext ) {
        self.note = note
        self.context = context
    }
    
    private func saveNote() {
        let request = NoteManagedData.fetchRequest() as NSFetchRequest<NoteManagedData>
        request.predicate = NSPredicate(format: "noteId == %@", note.noteId as CVarArg)
        if let note = try? context.fetch(request).first{
            note.timestamp = Date()
            note.title = note.title
            note.title = note.title
        }else {
            let newNote = NoteManagedData(context: context)
            newNote.timestamp = Date()
            newNote.title = note.title
            newNote.title = note.title
        }
    
        do {
            try context.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }

}
