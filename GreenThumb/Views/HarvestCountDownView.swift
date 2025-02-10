//
//  HarvestCountDownView.swift
//  GreenThumb
//
//  Created by Mohammad Azam on 2/10/25.
//

import SwiftUI

struct HarvestCountDownView: View {
    
    let plantingData: Date
    let harvestingDays: Int
    
    private var daysElapsed: Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: plantingData, to: Date())
        return max(components.day ?? 0, 0)
    }
    
    private var daysRemaining: Int {
        max(harvestingDays - daysElapsed, 0)
    }
    
    private var progress: CGFloat {
        CGFloat(daysElapsed) / CGFloat(harvestingDays)
    }
    
    var body: some View {
        ZStack {
            
            // Background Circle
            Circle()
                .stroke(
                    Color.green.opacity(0.2),
                    style: StrokeStyle(lineWidth: 8, lineCap: .round)
                )
            
            // Progress Circle
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    Color.green,
                    style: StrokeStyle(lineWidth: 8, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
                .animation(.easeInOut(duration: 0.5), value: progress)
            
            // Days Remaining
            VStack(spacing: 2) {
                Text("\(daysRemaining)")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.green)
                Text("Days")
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
            
        }
        .frame(width: 60, height: 60)
        .padding()
    }
}

#Preview {
    HarvestCountDownView(plantingData: Date().daysAgo(60), harvestingDays: 90)
}
