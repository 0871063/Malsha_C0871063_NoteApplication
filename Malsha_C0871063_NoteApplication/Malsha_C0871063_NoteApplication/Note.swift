//
//  Note.swift
//  Malsha_C0871063_NoteApplication
//
//  Created by Malsha Lambton on 2022-10-22.
//

import Foundation

var incrementID = 0
struct Note {
    var note : String
    var noteId : Int
    
    init(note: String) {
        self.note = note
        self.noteId = incrementID
        incrementID += 1
    }
}
