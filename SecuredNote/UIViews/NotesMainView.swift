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
                        ForEach(viewModel.notes, id: \.noteId) { note in
                            NavigationLink {
                                NotesCoordinator().detailView(for: note, context: self.viewModel.context)
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
                        NavigationLink(destination: NotesCoordinator().newNotesView(with: self.viewModel.context)) { Image(systemName: "plus") }
                    }
                }
            }.onAppear {
                
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
