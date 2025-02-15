//
//  ChangePinView.swift
//  Karyah
//
//  Created by Prance Studio on 15/02/25.
//

import SwiftUI

struct ChangePinView: View {
    @Binding var isVisible: Bool  // Bind to parent to close
    @State private var existingPin = ""
    @State private var newPin = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Change PIN")
                    .font(.headline)
                    .fontWeight(.bold)
                
                Spacer()
                
                Button(action: {
                    withAnimation {
                        isVisible = false  // Close dropdown
                    }
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundColor(.gray)
                }
            }

            Text("Are you sure you want to change PIN?")
                .font(.subheadline)
                .foregroundColor(.gray)

            SecureField("Enter Existing PIN", text: $existingPin)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            SecureField("Enter New PIN", text: $newPin)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            HStack {
                Button("No, cancel") {
                    withAnimation {
                        isVisible = false  // Close dropdown on cancel
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.red.opacity(0.2))
                .foregroundColor(.red)
                .cornerRadius(8)

                Button("Yes, Change") {
                    // Change PIN logic here
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
            }
        }
        .padding()
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(radius: 4)
    }
}
