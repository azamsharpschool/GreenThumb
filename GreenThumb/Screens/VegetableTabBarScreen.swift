//
//  VegetableTabBarScreen.swift
//  GreenThumb
//
//  Created by Mohammad Azam on 2/9/25.
//

import SwiftUI

struct VegetableTabBarScreen: View {
    var body: some View {
        TabView {
            
            NavigationStack {
                VegetableListScreen()
            }.tabItem {
                    Image(systemName: "leaf")
                    Text("Vegetables")
                }
            
            NavigationStack {
                MyGardenScreen() 
            }.tabItem {
                    Image(systemName: "house")
                    Text("My Garden")
                }
            
            NavigationStack {
                Text("Pests")
            }.tabItem {
                    Image(systemName: "ladybug")
                    Text("Pests")
                }
            
        }
    }
}

#Preview {
    VegetableTabBarScreen()
        .modelContainer(previewContainer)
}
