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
    
    @State var viewModel: NotesMainViewModel
    
    var body: some View {
        
        NavigationView {
            ZStack() {
                Group {
                    List {
                        ForEach(viewModel.notes, id: \.noteId) { note in
                            NavigationLink {
                                NotesCoordinator().detailView(for: note)
                            } label: {
                                Text(note.title)
                            }
                        }
                        .onDelete(perform: deleteNote)
                    }
                }
                .background(Color(red: 0.78, green: 0.78, blue: 0.91))
                .cornerRadius(4)
            }
            .navigationTitle("Notes")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(Color(red: 0.88, green: 0.88, blue: 1), for: .navigationBar)
            .toolbar {
                ToolbarItem {
                    Button(action: {}) {
                        NavigationLink(destination: NotesCoordinator().newNotesView()) { Image(systemName: "plus") }
                    }
                }
            }
            .alert("Error while deleting the note, Please try again", isPresented: $viewModel.errorWhileDelete) {
                Button("OK") { }
            }

        }
    }
    private func deleteNote(offsets: IndexSet) {
        Task { @MainActor in
            withAnimation {
                viewModel.deleteNote(offsets: offsets)
            }
        }
    }
    
}
#Preview {
    NotesMainView(viewModel: NotesMainViewModel(persistanceController: PersistenceController.preview))
}
