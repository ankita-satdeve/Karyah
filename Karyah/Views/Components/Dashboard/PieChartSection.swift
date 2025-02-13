//
//  PieChartSection.swift
//  Karyah
//
//  Created by apple on 05/02/25.
//

import SwiftUI
import Charts

struct ChartData: Identifiable {
    let id = UUID()
    let category: String
    let value: Double
    let color: Color
}

struct PieChartSection: View {
    let data: [ChartData] = [
        ChartData(category: "User", value: 40, color: .blue),
        ChartData(category: "Project", value: 30, color: .purple),
        ChartData(category: "Task", value: 30, color: .red)
    ]

    var body: some View {
        VStack {
            Chart {
                ForEach(data) { item in
                    SectorMark(
                        angle: .value("Value", item.value),
                        innerRadius: .ratio(0.5),
                        outerRadius: .ratio(0.9)
                    )
                    .foregroundStyle(item.color)
                }
            }
            .frame(height: 200)
            .chartLegend(position: .bottom, alignment: .center)

            // Category Buttons
            HStack {
                ForEach(data) { item in
                    Button(action: {
                        // Handle category selection
                    }) {
                        Text(item.category)
                            .padding(.horizontal)
                            .padding(.vertical, 8)
                            .background(item.color.opacity(0.2))
                            .foregroundColor(item.color)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
            }
            .padding(.top, 10)
        }
        
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(UIColor.secondarySystemBackground))
                .shadow(radius: 5)
            
        )
//        .padding(.top, -200)
    }
        
}

// MARK: - Preview
struct PieChartSection_Previews: PreviewProvider {
    static var previews: some View {
        PieChartSection()
            .preferredColorScheme(.light)
    }
}
