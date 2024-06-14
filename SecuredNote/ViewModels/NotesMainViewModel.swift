//
//  NotesMainViewModel.swift
//  SecuredNote
//
//  Created by CHANDRA SEKARAN M on 11/06/2024.
//

import Foundation
import CoreData
import Combine

@Observable
class NotesMainViewModel {
    
    let context: NSManagedObjectContext
    
    private var notesManagedData: [NoteManagedData]!
    private var cancellables = Set<AnyCancellable>()
    
    var notes =  [Note]()
    
    private var fetchRequest: NSFetchRequest<NoteManagedData> {
        let request = NoteManagedData.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \NoteManagedData.timestamp, ascending: false)]
        return request
    }
    
    init(context: NSManagedObjectContext) {
        self.context = context
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
            notesManagedData = try context.fetch(fetchRequest)
            createNoteObjects()
        } catch {
            
        }
    }
    
    private func createNoteObjects() {
        var noteList = [Note]()
        print(notesManagedData)
        notesManagedData.forEach { managedData in
            if let noteId = managedData.noteId,
               let title = managedData.title,
               let content = managedData.content {
                
                noteList.append(Note(noteId: noteId, title: title, content: content))
                print(noteList)
            }
        }
        self.notes = noteList
    }
    
    func deleteNote(offsets: IndexSet) {
        offsets.map { notesManagedData[$0] }.forEach(context.delete)
        do {
            try context.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
}
