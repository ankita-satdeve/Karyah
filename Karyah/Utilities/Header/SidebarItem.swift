//
//  SidebarItem.swift
//  Karyah
//
//  Created by apple on 06/02/25.
//

import SwiftUI

struct SidebarItem: View {
    var icon: String
    var title: String
    var isHighlighted: Bool = false
    var action: (() -> Void)? = nil // Action when tapped

    var body: some View {
        Button(action: {
            action?()
        }) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(isHighlighted ? .blue : .black)
                    .frame(width: 24, height: 24)

                Text(title)
                    .foregroundColor(isHighlighted ? .blue : .black)
                    .font(.system(size: 18))

                Spacer()
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 20)
        }
        .buttonStyle(PlainButtonStyle())
    }
}
