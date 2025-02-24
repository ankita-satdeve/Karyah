//
//  CircularProgressView.swift
//  Karyah
//
//  Created by Prance Studio on 20/02/25.
//

import SwiftUI

struct CircularProgressView: View {
    let progress: Int?
    
    var body: some View {
        let progressValue = CGFloat(progress ?? 0) / 100
        
        ZStack {
            Circle()
                .stroke(lineWidth: 5)
                .foregroundColor(Color.gray.opacity(0.3))
            Circle()
                .trim(from: 0, to: progressValue)
                .stroke(style: StrokeStyle(lineWidth: 5, lineCap: .round))
                .foregroundColor(Color(hex: "B9361F"))
                .rotationEffect(Angle(degrees: -90))
            Text("\(progress ?? 0)%")
                .font(.headline)
                .foregroundColor(.primary)
                .bold()
        }
        .frame(width: 60, height: 60)
    }
}
