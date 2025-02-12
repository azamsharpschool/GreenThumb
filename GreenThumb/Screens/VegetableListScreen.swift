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
            }
        }
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
