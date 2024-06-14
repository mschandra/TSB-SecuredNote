//
//  NoteDetailViewModel.swift
//  SecuredNote
//
//  Created by CHANDRA SEKARAN M on 12/06/2024.
//

import Foundation
import CoreData

@Observable
class NoteDetailViewModel: NotesVMProtocol {
    var errorWhileSaving = false
    var note: Note
    @ObservationIgnored
    var persistanceController: PersistenceController

    init(note: Note,
         persistanceController: PersistenceController = PersistenceController.shared ) {
        self.note = note
        self.persistanceController = persistanceController
    }

    func saveNote() async {
        let request = NoteEntity.fetchRequest() as NSFetchRequest<NoteEntity>
        request.predicate = NSPredicate(format: "noteId == %@", note.noteId as CVarArg)
        let context = persistanceController.container.viewContext
        if let existingNote = try? context.fetch(request).first {
            existingNote.timestamp = Date()
            existingNote.title = note.title
            existingNote.content = note.content
        } else {
            let newNote = NoteEntity(context: context)
            newNote.timestamp = Date()
            newNote.noteId = note.noteId
            newNote.title = note.title
            newNote.content = note.content
        }
        do {
            try self.persistanceController.saveContext()
        } catch {
            let nserror = error as NSError
            print("Core-data error \(nserror), \(nserror.userInfo)")
        }
    }

}
