//
//  SettingsOptionsView.swift
//  Karyah
//
//  Created by Prance Studio on 14/02/25.
//

import SwiftUI

struct SettingsOptionsView: View {
    var body: some View {
        VStack {
            SettingsRow(title: "Change PIN", icon: "chevron.right")
            Divider()
            SettingsRow(title: "Biometric", icon: "chevron.right")
        }
        .padding(.horizontal)
    }
}
