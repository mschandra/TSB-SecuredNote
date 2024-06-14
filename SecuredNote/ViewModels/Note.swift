//
//  Note.swift
//  SecuredNote
//
//  Created by CHANDRA SEKARAN M on 12/06/2024.
//

import Foundation

struct Note {
    
    let noteId: UUID
    var title: String
    var content: String
    
    static var new: Note {
        return Note(noteId: UUID(), title: "", content: "")
    }
}
