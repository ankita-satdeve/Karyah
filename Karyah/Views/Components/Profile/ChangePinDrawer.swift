//
//  ChangePinDrawer.swift
//  Karyah
//
//  Created by Prance Studio on 17/02/25.
//

import SwiftUI

struct ChangePinDrawer: View {
    @Binding var isVisible: Bool
    @State private var existingPin = ""
    @State private var newPin = ""

    var body: some View {
        VStack {
            Spacer()

            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Image("changePin")
                    Text("Change PIN")
                        .font(.title2)
                        .fontWeight(.bold)

                    Spacer()

                    Button(action: {
                        withAnimation {
                            isVisible = false  // Close drawer
                        }
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundColor(.gray)
                    }
                }
                .padding()

                Divider()

                Text("Are you sure you want to change PIN?")
                    .font(.headline)
                    .foregroundColor(.primary)
                    .padding(.horizontal)

                CustomTextField(
                    placeholder: "Enter Existing PIN",
                    text: $existingPin
                )
                .padding(.horizontal)

                Text("Forgot PIN?")
                    .font(.headline)
                    .foregroundColor(.blue)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.horizontal)

                CustomTextField(
                    placeholder: "Enter New PIN",
                    text: $newPin
                )
                .padding(.horizontal)

                HStack {
                    Button("No, Cancel") {
                        withAnimation {
                            isVisible = false  // Close drawer
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(hex: "#FFF2F2"))
                    .foregroundColor(.red)
                    .cornerRadius(14)
                    .overlay(
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(Color(hex: "#FFE5E5"), lineWidth: 2)
                    )

                    Button("Yes, Change") {
                        // Handle PIN change logic here
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(hex: "#ECEFFF"))
                    .foregroundColor(.primary)
                    .cornerRadius(14)
                    .overlay(
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(Color(hex: "#DEE3FF"), lineWidth: 2)
                    )
                }
                .padding()
            }
            .padding(.bottom, 50)
            .frame(maxWidth: .infinity)
            .background(Color(.systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: -5) //.shadow(radius: 5)
//            .padding(.bottom, 100)
        }
        .padding(.horizontal, -20)
        .frame(maxHeight: .infinity, alignment: .bottom)
        .edgesIgnoringSafeArea(.bottom)
    }
}
