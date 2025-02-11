//
//  PreviewData.swift
//  GreenThumb
//
//  Created by Mohammad Azam on 2/8/25.
//

import Foundation

struct PreviewData {
    
    static func loadPests() -> [Pest] {
        
        let vegetables = loadVegetables()
        let allPests = vegetables.flatMap { $0.pests ?? [] }
        
        return Array(Set(allPests.map { $0.name.lowercased() }))
            .compactMap { name in
                allPests.first { $0.name.lowercased() == name }
        }
        
    }
    
    static func loadVegetables() -> [Vegetable] {
        
        guard let url = Bundle.main.url(forResource: "vegetables", withExtension: "json") else {
            return []
        }
        
        do {
            let data = try Data(contentsOf: url)
            let vegetables = try JSONDecoder().decode([Vegetable].self, from: data)
            return vegetables
        } catch {
            return []
        }
        
    }
    
}
