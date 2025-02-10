//
//  SeedOrSeedlingView.swift
//  GreenThumb
//
//  Created by Mohammad Azam on 2/9/25.
//

import SwiftUI

enum PlantOption: Codable {
    case seed
    case seedling
    
    var title: String {
        switch self {
            case .seed:
                return "Seed"
            case .seedling:
                return "Seedling"
        }
    }
    
    var icon: String {
        switch self {
            case .seed:
                return "leaf.fill"
            case .seedling:
                return "leaf.arrow.circlepath"
        }
    }
}

struct SeedOrSeedlingView: View {
    
    let onSelected: (PlantOption) -> Void
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            Text("Choose an Option")
                .font(.headline)
            
            HStack(spacing: 24) {
                OptionView(option: .seed, action: { option in
                    onSelected(option)
                    dismiss()
                })
                OptionView(option: .seedling, action: { option in
                    onSelected(option)
                    dismiss()
                })
            }
        }
        .padding()
        .background(Color(.systemGray6)) // Light background color
        .clipShape(RoundedRectangle(cornerRadius: 16.0, style: .continuous))
        .padding() // Outer padding for spacing
    }
}

struct OptionView: View {
    let option: PlantOption
    let action: (PlantOption) -> Void

    var body: some View {
        Button(action: {
            action(option)
        }) {
            HStack(spacing: 8) {
                Image(systemName: option.icon)
                    .foregroundColor(.green)
                Text(option.title)
                    .font(.subheadline)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(8)
        }
    }
}

#Preview {
    SeedOrSeedlingView(onSelected: { _ in })
}
