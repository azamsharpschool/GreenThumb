//
//  PreviewContainer.swift
//  GreenThumb
//
//  Created by Mohammad Azam on 2/9/25.
//

import Foundation
import SwiftData
import SwiftUI

struct SampleData: PreviewModifier {
    
    static func makeSharedContext() throws -> ModelContainer {
        previewContainer
    }
    
    func body(content: Content, context: ModelContainer) -> some View {
        content.modelContainer(context)
    }
}

extension PreviewTrait where T == Preview.ViewTraits {
    @MainActor static var sampleData: Self = .modifier(SampleData())
}


@MainActor
let previewContainer: ModelContainer = {
    
    let container = try! ModelContainer(for: Vegetable.self, MyGardenVegetable.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    
    let vegetables = PreviewData.loadVegetables().prefix(5)
    
    let gardeningNotes = [
        Note(title: "Planting Schedule", body: "Tomatoes: Spring, Carrots: Early Summer, Spinach: Fall."),
        Note(title: "Soil Preparation", body: "Add compost and test pH levels before planting."),
        Note(title: "Watering Tips", body: "Water early in the morning to prevent evaporation."),
        Note(title: "Pest Control", body: "Use neem oil or companion planting to deter aphids and beetles."),
        Note(title: "Harvesting Guide", body: "Pick tomatoes when fully red; carrots when tops are about 1 inch wide.")
    ]
    
    for vegetable in vegetables {
        container.mainContext.insert(vegetable)
    }
    
    for vegetable in vegetables {
        
        let myGardenVegetable = MyGardenVegetable(vegetable: vegetable, plantOption: .seed)
        
        let randomNumber = Int.random(in: 0...1)
        if randomNumber == 1 {
            myGardenVegetable.notes = gardeningNotes
        }
        
        let daysAgo = Int.random(in: 1...50) // planted days ago
        myGardenVegetable.datePlanted = Date().daysAgo(daysAgo)
        container.mainContext.insert(myGardenVegetable)
    }
    
    return container
    
}()

