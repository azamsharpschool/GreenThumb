//
//  VegetableDetailScreen.swift
//  GreenThumb
//
//  Created by Mohammad Azam on 2/9/25.
//

import SwiftUI

struct VegetableDetailScreen: View {
    
    let vegetable: Vegetable
    
    var body: some View {
        ScrollView {
            
            VStack(alignment: .leading, spacing: 16) {
                // Vegetable Image
                AsyncImage(url: vegetable.thumbnailImage) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(16)
                        .shadow(radius: 10)
                } placeholder: {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: 200)
                        .overlay(
                            ProgressView()
                                .scaleEffect(1.5)
                                .progressViewStyle(CircularProgressViewStyle(tint: .gray))
                        )
                }
                .frame(maxWidth: .infinity, maxHeight: 300)
                .padding(.bottom, 8)
                
                // Description
                Text(vegetable.body)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .lineSpacing(4)
                    .padding(.bottom, 8)
                
                Divider()
                
                Text("Quick Facts")
                    .font(.title2)
                    .fontWeight(.bold)
                
                DetailRow(icon: "leaf", title: "Seed Depth", value: vegetable.seedDepth)
                DetailRow(icon: "thermometer", title: "Germination Temp", value: vegetable.germinationSoilTemp)
                DetailRow(icon: "calendar", title: "Days to Germination", value: "\(vegetable.daysToGermination) days")
                DetailRow(icon: "sun.max", title: "Light Requirement", value: vegetable.light)
                DetailRow(icon: "drop", title: "Watering", value: vegetable.watering)
                DetailRow(icon: "leaf.arrow.triangle.circlepath", title: "Companions", value: vegetable.goodCompanions)
                DetailRow(icon: "exclamationmark.triangle", title: "Bad Companions", value: vegetable.badCompanions)
                DetailRow(icon: "heart.fill", title: "Health Benefits", value: vegetable.healthBenefits.isEmpty ? "N/A" : vegetable.healthBenefits)
                
                Divider()
                
                SectionHeader(title: "Growing Tips")
                Text(vegetable.growingDescription)
                    .font(.body)
                    .foregroundColor(.secondary)
                
                SectionHeader(title: "Harvest Tips")
                Text(vegetable.harvestDescription)
                    .font(.body)
                    .foregroundColor(.secondary)
                
            }.padding()
            
        }.navigationTitle(vegetable.name)
    }
}

struct SectionHeader: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(.headline)
            .foregroundColor(.primary)
            .padding(.top)
    }
}

struct DetailRow: View {
    
    let icon: String
    let title: String
    let value: String
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .foregroundColor(.green)
                .frame(width: 24, height: 24)
            VStack(alignment: .leading) {
                Text(title)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text(value)
                    .font(.body)
                    .foregroundColor(.primary)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    NavigationStack {
        VegetableDetailScreen(vegetable: PreviewData.loadVegetables()[0])
    }
}
