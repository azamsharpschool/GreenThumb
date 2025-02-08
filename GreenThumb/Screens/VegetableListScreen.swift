//
//  ContentView.swift
//  GreenThumb
//
//  Created by Mohammad Azam on 2/6/25.
//

import SwiftUI

struct VegetableListScreen: View {
    
    @State private var vegetables: [Vegetable] = []
    
    var body: some View {
        List(vegetables) { vegetable in
            VegetableCellView(vegetable: vegetable)
        }
        .listStyle(.plain)
        .task {
            do {
                let client = VegetableHTTPClient()
                vegetables = try await client.fetchVegetables()
            } catch {
                print(error.localizedDescription)
            }
        }.navigationTitle("Vegetables")
    }
}

#Preview {
    NavigationStack {
        VegetableListScreen()
    }
}
