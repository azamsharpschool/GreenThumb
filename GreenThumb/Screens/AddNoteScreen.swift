//
//  AddNoteScreen.swift
//  GreenThumb
//
//  Created by Mohammad Azam on 2/10/25.
//

import SwiftUI
import SwiftData

struct AddNoteScreen: View {
    
    let myGardenVegetable: MyGardenVegetable
    
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    @State private var noteTitle: String = ""
    @State private var noteBody: String = ""
    
    private func saveNote() {
        // save a new note
        let note = Note(title: noteTitle, body: noteBody)
        myGardenVegetable.notes?.append(note)
        try? context.save()
    }
    
    var body: some View {
        Form {
            TextField("Title", text: $noteTitle)
            TextEditor(text: $noteBody)
                    .frame(minHeight: 200)
        }.toolbar {
            
            ToolbarItem(placement: .topBarLeading) {
                Button("Cancel") {
                    dismiss()
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    saveNote()
                }
            }
        }
    }
}

#Preview(traits: .sampleData) {
    
    @Previewable @Query var myGardenVegetables: [MyGardenVegetable]
    AddNoteScreen(myGardenVegetable: myGardenVegetables[0])
}
