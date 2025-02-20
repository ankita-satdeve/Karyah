//
//  FloatingAddProjectButton.swift
//  Karyah
//
//  Created by Prance Studio on 20/02/25.
//

import SwiftUI

struct FloatingAddProjectButton: View {
    @State private var isSheetPresented = false
    
    var body: some View {
        ZStack {
            
            // Floating Button
            VStack {
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
    FloatingAddProjectButton()
}

//import SwiftUI
//
//struct FloatingAddProjectButton: View {
//    @State private var isSheetPresented = false
//    
//    var body: some View {
//        ZStack {
//            VStack {
//                Button(action: {
//                    isSheetPresented.toggle()
//                }) {
//                    Image(systemName: "plus")
//                        .font(.title)
//                        .foregroundColor(.white)
//                        .padding()
//                        .background(Circle().fill(Color.red))
//                        .shadow(radius: 5)
//                }
//                .offset(y: -25) // Lift button above white background
//                .sheet(isPresented: $isSheetPresented) {
//                    BottomDrawerProjectView()
//                        .presentationDetents([.medium, .large]) // Makes it resizable
//                        .presentationDragIndicator(.visible) // Allows swipe down
//                }
//            }
//        }
//        .edgesIgnoringSafeArea(.bottom)
//    }
//}
//
//struct BottomDrawerProjectView: View {
//    var body: some View {
//        VStack {
//            TwoButtons()
//            Spacer()
//        }
//        .padding()
//    }
//}
//
//struct TwoButtons: View {
//    var body: some View {
//        HStack {
//            Button(action: {
//                print("Task button tapped")
//            }) {
//                Text("Task")
//                    .padding()
//                    .background(Color.blue)
//                    .foregroundColor(.white)
//                    .cornerRadius(8)
//            }
//            
//            Button(action: {
//                print("Project button tapped")
//            }) {
//                Text("Project")
//                    .padding()
//                    .background(Color.green)
//                    .foregroundColor(.white)
//                    .cornerRadius(8)
//            }
//        }
//    }
//}
//
//#Preview {
//    FloatingAddProjectButton()
//}
