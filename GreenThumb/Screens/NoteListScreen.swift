//
//  NoteListScreen.swift
//  GreenThumb
//
//  Created by Mohammad Azam on 2/10/25.
//

import SwiftUI
import SwiftData

struct NoteListScreen: View {
    
    let myGardenVegetable: MyGardenVegetable
    @State private var addNotePresented: Bool = false
    
    @Environment(\.modelContext) private var context
    
    private func deleteNote(at indexSet: IndexSet) {
        
        guard let notes = myGardenVegetable.notes else { return }
        
        for index in indexSet {
            let note = notes[index]
            context.delete(note)
            try? context.save()
        }
        
    }
    
    var body: some View {
        List {
            ForEach(myGardenVegetable.notes ?? []) { note in
                NoteCellView(note: note, placeHolderImage: myGardenVegetable.vegetable.thumbnailImage)
            }.onDelete(perform: deleteNote)
        }
        .navigationTitle(myGardenVegetable.vegetable.name)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add Note") {
                        addNotePresented = true
                    }
                }
            }.sheet(isPresented: $addNotePresented) {
                NavigationStack {
                    AddNoteScreen(myGardenVegetable: myGardenVegetable)
                }
            }
    }
}
  
#Preview(traits: .sampleData) {
    
    @Previewable @Query var myGardenVegetables: [MyGardenVegetable]
    
    NavigationStack {
        NoteListScreen(myGardenVegetable: myGardenVegetables[0])
    }
}
