//
//  Note.swift
//  SecuredNote
//
//  Created by CHANDRA SEKARAN M on 12/06/2024.
//

import Foundation

struct Note {
    
    let noteId: UUID
    let title: String
    let content: String
    
    static func newNote() -> Note {
        return Note(noteId: UUID(), title: "", content: "")
    }
}
