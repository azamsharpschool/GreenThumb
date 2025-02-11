//
//  PestListScreen.swift
//  GreenThumb
//
//  Created by Mohammad Azam on 2/11/25.
//

import SwiftUI

struct PestListScreen: View {
    
    let pests: [Pest]
    
    var body: some View {
        List(pests) { pest in
            NavigationLink {
                    PestDetailScreen(pest: pest)
            }   label: {
                    PestCellView(pest: pest)
            }
            
        }
        .listStyle(.plain)
        .navigationTitle("Pests")
    }
}

#Preview(traits: .sampleData) {
    NavigationStack {
        PestListScreen(pests: PreviewData.loadPests())
    }
}
