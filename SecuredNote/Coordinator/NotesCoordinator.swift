//
//  NotesCoordinator.swift
//  SecuredNotes
//
//  Created by CHANDRA SEKARAN M on 14/06/2024.
//

import Foundation
import SwiftUI
import CoreData

class NotesCoordinator {
    
    @MainActor func mainView(context: NSManagedObjectContext) -> some View{
        NotesMainView(viewModel: NotesMainViewModel())
    }
    
    @MainActor func detailView(for note:Note) -> some View{
        let vm = NoteDetailViewModel(note: note)
        return NoteDetailUIView(viewModel:
                            vm, isEditMode: false,
                         isNew: false)
    }
    
    @MainActor func newNotesView() -> some View{
        let vm = NoteDetailViewModel(note: Note.new)
        return NoteDetailUIView(viewModel:
                            vm, isEditMode: true,
                         isNew: true)
    }
    
}
