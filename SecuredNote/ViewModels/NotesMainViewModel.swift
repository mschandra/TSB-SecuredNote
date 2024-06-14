//
//  NotesMainViewModel.swift
//  SecuredNote
//
//  Created by CHANDRA SEKARAN M on 11/06/2024.
//

import Foundation
import CoreData
import Combine

protocol NotesVMProtocol {
    var persistanceController: PersistenceController {get set}
}
@MainActor
@Observable
class NotesMainViewModel {
    var errorWhileDelete = false
    var notes =  [Note]()

    @ObservationIgnored
    var persistanceController: PersistenceController
    private let context: NSManagedObjectContext
    private var noteEntities: [NoteEntity]!
    private var cancellables = Set<AnyCancellable>()

    private var fetchRequest: NSFetchRequest<NoteEntity> {
        let request = NoteEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \NoteEntity.timestamp, ascending: false)]
        return request
    }

    init(persistanceController: PersistenceController = PersistenceController.shared ) {
        self.persistanceController = persistanceController
        self.context = persistanceController.container.viewContext
        self.setup()
        self.refreshNotes()
    }

    private func setup() {
        NotificationCenter.default.publisher(for: .NSManagedObjectContextObjectsDidChange, object: context)
            .sink { [weak self] _ in
                self?.refreshNotes()
            }
            .store(in: &cancellables)
    }

    private func refreshNotes() {
        do {
            noteEntities = try context.fetch(fetchRequest)
            self.notes = noteEntities.compactMap { note in
                if let noteId = note.noteId,
                   let title = note.title,
                   let content = note.content {
                    return Note(noteId: noteId, title: title, content: content)
                } else {
                    return nil
                }
            }
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }

    func deleteNote(offsets: IndexSet) {
        offsets.map { noteEntities[$0] }.forEach(context.delete)
        do {
            try context.save()
        } catch {
            errorWhileDelete = true
            let nsError = error as NSError
            print("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }

}
