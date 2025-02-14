//
//  ProfileImageView.swift
//  Karyah
//
//  Created by Prance Studio on 14/02/25.
//

import SwiftUI

struct ProfileImageView: View {
    let url: String?
    let geometry: GeometryProxy
    
    var body: some View {
        if let urlString = url, let imageUrl = URL(string: urlString) {
            AsyncImage(url: imageUrl) { image in
                image.resizable()
                    .scaledToFit()
                    .frame(width: geometry.size.width / 3, height: geometry.size.width / 3)
                    .clipShape(Circle())
            } placeholder: {
                ProgressView()
            }
            .accessibilityLabel("Profile Picture")
        } else {
            Image(systemName: "person.crop.square.badge.camera.fill")
                .resizable()
                .scaledToFit()
                .frame(width: geometry.size.width / 4, height: geometry.size.width / 4)
                .foregroundColor(.primary)
                .accessibilityLabel("Profile Picture")
        }
    }
}
