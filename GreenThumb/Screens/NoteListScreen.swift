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
    
    var body: some View {
        List(myGardenVegetable.notes ?? []) { note in
            HStack {
                
                if let photoData = note.photo,
                   let uiImage = UIImage(data: photoData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 75, height: 75)
                        .clipShape(Circle())
                        .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
                }
                
                Text(note.title)
            }
        }
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
