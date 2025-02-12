//
//  PestListScreen.swift
//  GreenThumb
//
//  Created by Mohammad Azam on 2/11/25.
//

import SwiftUI

struct PestListScreen: View {
    
    let pests: [Pest]
    @State private var search: String = ""
    
    private var filteredPests: [Pest] {
        if search.isEmptyOrWhiteSpace {
            return pests
        } else {
            return pests.filter { $0.name.localizedCaseInsensitiveContains(search) }
        }
    }
    
    var body: some View {
        List(filteredPests) { pest in
            NavigationLink {
                    PestDetailScreen(pest: pest)
            }   label: {
                    PestCellView(pest: pest)
            }
            
        }
        .searchable(text: $search)
        .listStyle(.plain)
        .navigationTitle("Pests")
    }
}

#Preview(traits: .sampleData) {
    NavigationStack {
        PestListScreen(pests: PreviewData.loadPests())
    }
}
