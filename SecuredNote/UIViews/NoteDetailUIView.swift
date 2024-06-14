//
//  NoteDetailUIView.swift
//  SecuredNotes
//
//  Created by CHANDRA SEKARAN M on 13/06/2024.
//

import Foundation
import SwiftUI

struct NoteDetailUIView: View {
    @Environment(\.presentationMode) private var mode
    @State var viewModel: NoteDetailViewModel
    @State var isEditMode: Bool
    @State var isNew: Bool
    var isReadyOnly: Bool {
        return !(self.isEditMode || self.isNew)
    }
    var hasTitle: Bool {
        return !viewModel.note.title.isEmpty
    }
    var body: some View {

        VStack(alignment: .center) {
            Group {
                TextField("Title ", text: $viewModel.note.title)
                    .font(Font.custom("Poppins", size: 14))
                    .foregroundColor(isReadyOnly ? .gray: .black)
                    .padding(.vertical, 20).padding(.horizontal, 20)
                    .textFieldStyle(.roundedBorder)
                    .disabled(isReadyOnly)
                    .disableAutocorrection(true)
                TextEditor(text: $viewModel.note.content)
                    .font(Font.custom("Poppins", size: 14))
                    .padding(.vertical, 20).padding(.horizontal, 20)
                    .foregroundColor(isReadyOnly ? .gray: .black)
                    .disabled(isReadyOnly)
                    .disableAutocorrection(true)
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 0.78, green: 0.78, blue: 0.91))
        .cornerRadius(4)
        .padding()
        .navigationTitle("Note Details")
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarBackground(Color(red: 0.88, green: 0.88, blue: 1), for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    if self.isNew == true || self.isEditMode == true {
                        viewModel.saveNote()
                        mode.wrappedValue.dismiss()
                    } else {
                        self.isEditMode = true
                    }
                }) {
                    Text(self.isEditMode || self.isNew ? "Save" : "Edit")
                }.disabled(!hasTitle)
            }
        }
        .alert("Error while saving the note, Please try again", isPresented: $viewModel.errorWhileSaving) {
            Button("OK") { }
        }
    }
}

#Preview {
    NoteDetailUIView(viewModel: NoteDetailViewModel(note: Note.new,
                                                    persistanceController: PersistenceController.preview),
                     isEditMode: true,
                     isNew: true)

}
