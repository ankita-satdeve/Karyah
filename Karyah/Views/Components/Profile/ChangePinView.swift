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
                Image("changePin")
                Text("Change PIN")
                    .font(.title2)
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
            
            Divider()

            Text("Are you sure you want to change PIN?")
                .font(.headline)
                .foregroundColor(.primary)
            
            CustomTextField(
                placeholder: "Enter Existing PIN",
                text: $existingPin)

            
            Text("Forgot PIN?")
                .font(.headline)
                .foregroundColor(.blue)
                .frame(maxWidth: .infinity, alignment: .trailing)

            CustomTextField(
                placeholder: "Enter New PIN",
                text: $newPin)
            
            
            HStack {
                Button("No, cancel") {
                    withAnimation {
                        isVisible = false  // Close dropdown on cancel
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
                    // Change PIN logic here
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
            .padding(.top, 30)
        }
       
        .padding()
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 14))
//        .shadow(radius: 4)
    }
}
