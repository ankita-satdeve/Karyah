//
//  CircularProgressView.swift
//  Karyah
//
//  Created by Prance Studio on 20/02/25.
//

import SwiftUI

struct CircularProgressView: View {
    let progress: Double
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 5)
                .foregroundColor(Color.gray.opacity(0.3))
            Circle()
                .trim(from: 0.0, to: CGFloat(progress))
                .stroke(style: StrokeStyle(lineWidth: 5, lineCap: .round))
                .foregroundColor(Color(hex: "B9361F"))
                .rotationEffect(Angle(degrees: -90))
            Text("\(Int(progress * 100))%")
                .font(.headline)
                .foregroundColor(.primary)
                .bold()
        }
        .frame(width: 60, height: 60)
    }
}
