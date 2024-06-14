//
//  SecuredNoteTests.swift
//  SecuredNoteTests
//
//  Created by CHANDRA SEKARAN M on 11/06/2024.
//

import XCTest
@testable import SecuredNotes

final class SecuredNoteTests: XCTestCase {

    @MainActor func testSaveDetailViewModel() async {

        let persistenceController = PersistenceController.preview
        let notesMainVM = NotesMainViewModel(persistanceController: persistenceController)
        let expectation = expectation(description: "test_MainViewModel")
        let initCount = notesMainVM.notes.count
        withObservationTracking {
            _ = notesMainVM.notes
        } onChange: {
            expectation.fulfill()
        }

        let notesDetailVM = NoteDetailViewModel(note: Note.new, persistanceController: persistenceController)
        await notesDetailVM.saveNote()
        await fulfillment(of: [expectation], timeout: 10)
        XCTAssertEqual(notesMainVM.notes.count, initCount+1)

    }

    @MainActor func testDeleteDetailViewModel() async {
        let persistenceController = PersistenceController.preview
        let notesManinVM = NotesMainViewModel(persistanceController: persistenceController)
        let expectation = expectation(description: "test_MainViewModel")
        let initCount = notesManinVM.notes.count

        let viewContext = persistenceController.container.viewContext
        for _ in 0..<10 {
            let newItem = NoteEntity(context: viewContext)
            newItem.timestamp = Date()
            newItem.noteId = UUID()
            newItem.title = "Testing"
            newItem.content = "test_MainViewModel"
        }
        do {
           try persistenceController.saveContext()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        withObservationTracking {
            _ = notesManinVM.notes
        } onChange: {
            expectation.fulfill()
        }
        await notesManinVM.deleteNote(offsets: IndexSet(integer: 0))

        await fulfillment(of: [expectation], timeout: 10)
        XCTAssertEqual(notesManinVM.notes.count, initCount+9)
    }

    @MainActor func testUpdateDetailViewModel() async {

        let persistenceController = PersistenceController.preview
        let notesMainVM = NotesMainViewModel(persistanceController: persistenceController)
        let expectation = expectation(description: "test_MainViewModel")
        let notesDetailVM = NoteDetailViewModel(note: Note.new, persistanceController: persistenceController)
        await notesDetailVM.saveNote()

        withObservationTracking {
            _ = notesMainVM.notes
        } onChange: {
            expectation.fulfill()
        }
        notesDetailVM.note.title = "hello"
        await notesDetailVM.saveNote()
        await fulfillment(of: [expectation], timeout: 10)
        XCTAssertEqual(notesMainVM.notes.first?.title, "hello")
    }

    @MainActor func testMainViewModel() async {
        let persistenceController = PersistenceController.preview
        let notesManinVM = NotesMainViewModel(persistanceController: persistenceController)
        let expectation = expectation(description: "test_MainViewModel")
        let initCount = notesManinVM.notes.count
        let viewContext = persistenceController.container.viewContext
        withObservationTracking {
            _ = notesManinVM.notes
        } onChange: {
            expectation.fulfill()
        }
        do {
            let newItem = NoteEntity(context: viewContext)
            newItem.timestamp = Date()
            newItem.noteId = UUID()
            newItem.title = "Testing"
            newItem.content = "test_MainViewModel"
            try persistenceController.saveContext()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        await fulfillment(of: [expectation], timeout: 40)
        XCTAssertEqual(notesManinVM.notes.count, initCount+1)

    }
}
