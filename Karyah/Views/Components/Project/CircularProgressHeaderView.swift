//
//  CircularProgressHeaderView.swift
//  Karyah
//
//  Created by Prance Studio on 20/02/25.
//

import SwiftUI

struct CircularProgressHeaderView: View {
    let progress: Int?
    
    var body: some View {
        let progressValue = CGFloat(progress ?? 0) / 100  // ✅ Ensure conversion is correct

        ZStack {
            Circle()
                .stroke(lineWidth: 10)
                .foregroundColor(.white)

            Circle()
                .trim(from: 0, to: progressValue)  // ✅ Now correctly using CGFloat
                .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round))
                .foregroundColor(.orange)
                .rotationEffect(Angle(degrees: -90))

            Text("\(progress ?? 0)%")  // ✅ Displays correct progress
                .font(.headline)
                .bold()
        }
    }
}
