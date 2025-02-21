//
//  FloatingMenuView.swift
//  Karyah
//
//  Created by Prance Studio on 21/02/25.
//

import SwiftUI

struct FloatingMenuView: View {
    @State private var isExpanded = false
    @State private var isSheetPresentedTask = false
    @State private var isSheetPresentedProject = false
    
    var body: some View {
        ZStack {
            VStack {
                if isExpanded {
                    HStack(spacing: 0) {
                        Button(action: {
                            print("Task clicked")
                            isSheetPresentedTask.toggle()
                        }) {
                            Text("Task")
                                .frame(width: 80, height: 40)
                                .foregroundColor(.primary)
                                .background(Color.white)
                                .cornerPRadius(10, corners: [.topLeft, .bottomLeft])
                        }
                        .sheet(isPresented: $isSheetPresentedTask) {
                            TaskBottomDrawerView()
                                .presentationDetents([.medium]) // Makes it resizable
//                                .presentationDetents([.fraction(0.3)]) // 30% of screen height
//                                .presentationDragIndicator(.visible) // Allows swipe down
                        }
                        
                        Divider()
                            .frame(height: 40)
                        
                        Button(action: {
                            print("Project clicked")
                            isSheetPresentedProject.toggle()
                        }) {
                            Text("Project")
                                .frame(width: 80, height: 40)
                                .foregroundColor(.primary)
                                .background(Color.white)
                                .cornerPRadius(10, corners: [.topRight, .bottomRight])
                        }
                        .sheet(isPresented: $isSheetPresentedProject) {
                            ProjectBottomDrawerView()
                                .presentationDetents([.medium]) // Makes it resizable
//                                .presentationDetents([.fraction(0.3)]) // 30% of screen height
//                                .presentationDragIndicator(.visible) // Allows swipe down
                        }
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.gray)
                            .shadow(radius: 5)
//                            .overlay(Triangle()
//                                .fill(Color(.systemBackground))
//                                .frame(width: 20, height: 10)
//                                .offset(y: 5), alignment: .bottom)
                    )
                    .transition(.scale)
                }
                
                Button(action: {
                    withAnimation {
                        isExpanded.toggle()
                    }
                }) {
                    Image(systemName: "plus")
                        .foregroundColor(.white)
                        .font(.system(size: 24, weight: .bold))
                        .frame(width: 60, height: 60)
                        .background(Color(hex: "DC4238"))
                        .clipShape(Circle())
                        .shadow(radius: 10)
                }
            }
        }
    }
}

// Helper to round specific corners
extension View {
    func cornerPRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedPCorner(radius: radius, corners: corners))
    }
}

struct RoundedPCorner: Shape {
    var radius: CGFloat
    var corners: UIRectCorner
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

#Preview {
    FloatingMenuView()
}


//struct Triangle: Shape {
//    func path(in rect: CGRect) -> Path {
//        var path = Path()
//        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
//        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
//        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
//        path.closeSubpath()
//        return path
//    }
//}
