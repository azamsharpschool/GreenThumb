//
//  GreenThumbApp.swift
//  GreenThumb
//
//  Created by Mohammad Azam on 2/6/25.
//

import SwiftUI

@main
struct GreenThumbApp: App {
    var body: some Scene {
        WindowGroup {
            VegetableTabBarScreen()
                .modelContainer(for: [Vegetable.self, MyGardenVegetable.self, Note.self])
        }
    }
}
