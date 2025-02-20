//
//  FloatingAddButton.swift
//  Karyah
//
//  Created by apple on 05/02/25.
//

import SwiftUI

struct FloatingAddButton: View {
    @State private var isSheetPresented = false
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                
                // White Background Strap
                Rectangle()
                    .fill(Color(.systemBackground))
                    .frame(height: 50)
                    .shadow(radius: 2)
            }
            
            // Floating Button
            VStack {
                Spacer()
                Button(action: {
                    isSheetPresented.toggle()
                }) {
                    Image(systemName: "plus")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()
                        .background(Circle().fill(Color.red))
                        .shadow(radius: 5)
                }
                .offset(y: -25) // Lift button above white background
                .sheet(isPresented: $isSheetPresented) {
                    BottomDrawerView()
                        .presentationDetents([.medium, .large]) // Makes it resizable
                        .presentationDragIndicator(.visible) // Allows swipe down
                }
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}


#Preview {
    FloatingAddButton()
}

