//
//  NotesMainView.swift
//  SecuredNote
//
//  Created by CHANDRA SEKARAN M on 11/06/2024.
//

import SwiftUI
import LocalAuthentication

struct NotesMainView: View {
    
    @State private var isUnlocked = false
    
    var viewModel: NotesMainViewModel

    var body: some View {
        
        NavigationView {
            ZStack() {
                Group {
                    List {
                        ForEach(viewModel.notes, id: \.noteId) { item in
                            NavigationLink {
                                let vm = NoteDetailViewModel(note: item,
                                                                   context: self.viewModel.context)
                                NoteDetailUIView(viewModel:
                                                    vm, isEditMode: false,
                                isNew: false)
                            } label: {
                                Text(item.title)
                            }
                        }
                        .onDelete(perform: deleteNote)
                    }
                }
                .background(Color(red: 0.78, green: 0.78, blue: 0.91))
                .cornerRadius(24)
            }
            .toolbarBackground(.teal)
            .toolbar {
                ToolbarItem {
                    Button(action: {}) {
                        NavigationLink(destination:
                                        NoteDetailUIView(viewModel: NoteDetailViewModel(note: Note.newNote(),
                                                context: self.viewModel.context),
                                            isEditMode: true,
                                     isNew: true)) { Image(systemName: "plus") }
                    }
                }
            }
        }
    }
    private func deleteNote(offsets: IndexSet) {
        withAnimation {
            viewModel.deleteNote(offsets: offsets)
        }
    }
  
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

#Preview {
    NotesMainView(viewModel: NotesMainViewModel(context: PersistenceController.preview.container.viewContext)).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
