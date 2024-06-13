//
//  NoteDetailUIView.swift
//  SecuredNotes
//
//  Created by CHANDRA SEKARAN M on 13/06/2024.
//

import Foundation
import SwiftUI

struct NoteDetailUIView: View {
    var viewModel: NoteDetailViewModel
    @State var isEditMode: Bool
    @State var isNew: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            Group {
                Text(viewModel.note.title).font(.largeTitle).padding(.bottom)
                Text(viewModel.note.content).padding(.bottom)
                Spacer()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 0.78, green: 0.78, blue: 0.91))
        .cornerRadius(24)
        .padding()
        .navigationTitle("Note Details")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    self.isEditMode = true
                }) {
                    Text(self.isEditMode || self.isNew ? "Save" : "Edit")
                }
            }
        }
    }
}
