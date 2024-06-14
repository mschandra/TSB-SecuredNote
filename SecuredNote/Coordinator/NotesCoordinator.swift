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
    
    func mainView(context: NSManagedObjectContext) -> some View{
        NotesMainView(viewModel: NotesMainViewModel(context: context))
    }
    
    func detailView(for note:Note,
                    context: NSManagedObjectContext) -> some View{
        let vm = NoteDetailViewModel(note: note,
                                     context: context)
        return NoteDetailUIView(viewModel:
                            vm, isEditMode: false,
                         isNew: false)
    }
    
    func newNotesView(with context: NSManagedObjectContext) -> some View{
        let vm = NoteDetailViewModel(note: Note.new,
                                     context: context)
        return NoteDetailUIView(viewModel:
                            vm, isEditMode: true,
                         isNew: true)
    }
    
}
