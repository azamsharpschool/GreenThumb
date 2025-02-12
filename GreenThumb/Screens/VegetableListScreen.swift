//
//  ContentView.swift
//  GreenThumb
//
//  Created by Mohammad Azam on 2/6/25.
//

import SwiftUI

struct VegetableListScreen: View {
    
    let vegetables: [Vegetable]
    @State private var search: String = ""
    @State private var selectedVegetable: Vegetable?
    
    @Environment(\.modelContext) private var context
    
    private var filteredVegetables: [Vegetable] {
        if search.isEmptyOrWhiteSpace {
            return vegetables
        } else {
            return vegetables.filter { $0.name.localizedCaseInsensitiveContains(search) }
        }
    }
    
    var body: some View {
        List(filteredVegetables) { vegetable in
            NavigationLink {
                VegetableDetailScreen(vegetable: vegetable)
            } label: {
                VegetableCellView(vegetable: vegetable)
                    .swipeActions(edge: .trailing, content: {
                        Button {
                            selectedVegetable = vegetable
                        } label: {
                            Label("Add to Garden", systemImage: "plus")
                        }.tint(.green)

                    })
            }
        }
        .sheet(item: $selectedVegetable, content: { selectedVegetable in
            SeedOrSeedlingView { plantOption in
                
                let myGardenVegetable = MyGardenVegetable(vegetable: selectedVegetable, plantOption: plantOption)
                context.insert(myGardenVegetable)
                do {
                    try context.save()
                } catch {
                    print(error.localizedDescription)
                }
            }
            .presentationDetents([.fraction(0.25)])
            .presentationBackground(Color(.systemGray6))
            
        })
        .searchable(text: $search)
        .listStyle(.plain)
        .navigationTitle("Vegetables")
    }
}

#Preview(traits: .sampleData) {
    NavigationStack {
        VegetableListScreen(vegetables: PreviewData.loadVegetables())
    }
}
