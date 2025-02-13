//
//  SplashView.swift
//  Karyah
//
//  Created by Prance Studio on 13/02/25.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        VStack {
            Text("🚀 Loading...")
                .font(.largeTitle)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                AuthManager().checkAuthentication()
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
            .previewDevice("iPhone 16 Pro")
    }
}
