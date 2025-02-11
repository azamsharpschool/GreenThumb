//
//  VegetableDetailScreen.swift
//  GreenThumb
//
//  Created by Mohammad Azam on 2/9/25.
//

import SwiftUI
import SwiftData

struct VegetableDetailScreen: View {
    
    let vegetable: Vegetable
    @Environment(\.modelContext) private var context
    
    @State private var showSeedOrSeedlingMenu: Bool = false
    
    private func saveVegetableToMyGarden(with plantOption: PlantOption) {
        
        let myGardenVegetable = MyGardenVegetable(vegetable: vegetable, plantOption: plantOption)
        context.insert(myGardenVegetable)
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
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
                
                if let pests = vegetable.pests {
                    DetailRow(icon: "ladybug", title: "Pests", value: pests.isEmpty ? "N/A": pests.map { $0.name}.joined(separator: ", "))
                }
               
                
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
            
        }
        .toolbar(content: {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showSeedOrSeedlingMenu = true
                } label: {
                    Image(systemName: "plus")
                        .font(.title2) // Adjust size
                        .foregroundColor(.green)
                }

            }
        })
        .sheet(isPresented: $showSeedOrSeedlingMenu, content: {
            SeedOrSeedlingView(onSelected: { option in
                saveVegetableToMyGarden(with: option)
            })
            .presentationDetents([.fraction(0.25)])
            .presentationBackground(Color(.systemGray6))
        })
        
        .navigationTitle(vegetable.name)
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

#Preview(traits: .sampleData) {
    NavigationStack {
        VegetableDetailScreen(vegetable: PreviewData.loadVegetables()[0])
    }
}
