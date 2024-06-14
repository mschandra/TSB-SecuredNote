//
//  SecuredNoteTests.swift
//  SecuredNoteTests
//
//  Created by CHANDRA SEKARAN M on 11/06/2024.
//

import XCTest
@testable import SecuredNotes

final class SecuredNoteTests: XCTestCase {

    @MainActor func testMainViewModel() {

        let notesManinVM = NotesMainViewModel(persistanceController: PersistenceController.preview)
        let expectation = expectation(description: "test_MainViewModel")

        withObservationTracking {
            _ = notesManinVM.notes
        } onChange: {
            expectation.fulfill()
        }
        let viewContext = PersistenceController.preview.container.viewContext
        for _ in 0..<10 {
            let newItem = NoteEntity(context: viewContext)
            newItem.timestamp = Date()
            newItem.noteId = UUID()
            newItem.title = "Testing"
            newItem.content = "test_MainViewModel"
        }
        do {
           try PersistenceController.preview.saveContext()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        wait(for: [expectation], timeout: 10)
        XCTAssertEqual(notesManinVM.notes.count, 20)

    }

    @MainActor func testDetailViewModel() {

        let persistenceController = PersistenceController.preview
        let notesMainVM = NotesMainViewModel(persistanceController: persistenceController)
        let expectation = expectation(description: "test_MainViewModel")

        withObservationTracking {
            _ = notesMainVM.notes
        } onChange: {
            expectation.fulfill()
        }

        let notesDetailVM = NoteDetailViewModel(note: Note.new, persistanceController: persistenceController)
        notesDetailVM.saveNote()
        wait(for: [expectation], timeout: 10)
        XCTAssertEqual(notesMainVM.notes.count, 11)

    }
}
