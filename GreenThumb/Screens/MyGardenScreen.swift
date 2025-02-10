//
//  MyGardenScreen.swift
//  GreenThumb
//
//  Created by Mohammad Azam on 2/10/25.
//

import SwiftUI
import SwiftData

struct MyGardenScreen: View {
    
    @Query private var myGardenVegetables: [MyGardenVegetable]
    
    var body: some View {
        List(myGardenVegetables) { myGardenVegetable in
            NavigationLink {
                NoteListScreen(myGardenVegetable: myGardenVegetable)
            } label: {
                MyGardenCellView(myGardenVegetable: myGardenVegetable)
            }
        }
        .listStyle(.plain)
        .navigationTitle("My Garden")
    }
}

#Preview {
    NavigationStack {
        MyGardenScreen()
    }.modelContainer(previewContainer)
}
