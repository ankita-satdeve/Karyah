//
//  SidebarView.swift
//  Karyah
//
//  Created by apple on 06/02/25.
//

import SwiftUI

struct SidebarView: View {
    @Binding var isDrawerOpen: Bool
    @Binding var navigationPath: NavigationPath
//    @AppStorage("name") var name: String = ""
    @AppStorage("email") var email: String = ""


    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image("profile")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                    .padding()

                Text(email)
                    .font(.headline)
                    .bold()

                Spacer()

                Button(action: {
                    withAnimation {
                        isDrawerOpen.toggle()
                    }
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title)
                        .foregroundColor(.gray)
                        .padding()
                }
            }

            Divider()

            // Sidebar items with navigation actions
            SidebarItem(icon: "folder.fill", title: "Project") {
                navigate(to: .projectList)
            }
            SidebarItem(icon: "checklist", title: "Tasks") {
                navigate(to: .taskList)
            }
            SidebarItem(icon: "person.2.fill", title: "Connections") {
                navigate(to: .connectionList)
            }
            SidebarItem(icon: "person.crop.circle", title: "Profile") {
                navigate(to: .profile)
            }
            SidebarItem(icon: "gearshape.fill", title: "Settings") {
                navigate(to: .settings)
            }

            Spacer()

            SidebarItem(icon: "questionmark.circle.fill", title: "Help", isHighlighted: true) {
//            SidebarItem(icon: "questionmark.circle.fill", title: "Help", isHighlighted: true) {
                navigate(to: .help)
            }
        }
        .frame(width: 280)
        .background(Color.white.opacity(0.7).shadow(radius: 5))
        .padding(.top, 390)
        .padding(.leading, -120)
    }
    
    private func navigate(to destination: NavigationDestination) {
        withAnimation {
            isDrawerOpen = false
            navigationPath.append(destination)
        }
    }
}
