//
//  ContentView.swift
//  GreenThumb
//
//  Created by Mohammad Azam on 2/6/25.
//

import SwiftUI

struct VegetableListScreen: View {
    
    let vegetables: [Vegetable]
    
    var body: some View {
        List(vegetables) { vegetable in
            NavigationLink {
                VegetableDetailScreen(vegetable: vegetable)
            } label: {
                VegetableCellView(vegetable: vegetable)
            }
        }
        .listStyle(.plain)
        .navigationTitle("Vegetables")
    }
}

#Preview {
    NavigationStack {
        VegetableListScreen(vegetables: PreviewData.loadVegetables())
    }
}
