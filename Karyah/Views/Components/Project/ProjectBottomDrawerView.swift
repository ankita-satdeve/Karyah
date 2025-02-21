//
//  ProjectBottomDrawerView.swift
//  Karyah
//
//  Created by Prance Studio on 21/02/25.
//


import SwiftUI

struct ProjectBottomDrawerView: View {
    @Environment(\.dismiss) var dismiss
    @State private var navigateToCreateProject = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                VStack(spacing: 15) {
                    HStack {
                        Image("changePin")
                        Text("Create New Project")
                            .font(.title2).bold()
                            .foregroundColor(.primary)
                        Spacer()
                        Button(action: { dismiss() }) {
                            Image("close")
                                .background(Color(hex: "ECEFFF"))
                                .clipShape(Circle())
                        }
                    }
                    
                    Divider()
                        .frame(maxWidth: .infinity, maxHeight: 1)
                    
                    CustomInputFieldProjectName(icon: "", placeholder: "Project Name", text: .constant(""))
                        .padding(.vertical)
                    
                    LargeCustomInputFieldP(icon: "", placeholder: "Description", text: .constant(""))
                }
                .padding()

                ReusableButton(
                    title: "Continue",
                    foregroundColor: .white,
                    isDisabled: false,
                    action: {
                        // Handle continue action
                    }
                )

                HStack {
                    Text("Want to Add Complete Details? ")
                        .foregroundColor(Color(.systemGray3))

                    Button(action: { navigateToCreateProject = true }) {
                        Text("Click Here")
                            .foregroundColor(.blue)
                    }
                }
                .bold()

                Spacer()
            }
            .padding()
            .background(Color(.systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 40))
            .navigationDestination(isPresented: $navigateToCreateProject) {
                CreateProjectView()  // Replace with your actual destination view
            }
        }
    }
}


//import SwiftUI
//
//struct ProjectBottomDrawerView: View {
//    @Environment(\.dismiss) var dismiss
//    @State private var navigateToCreateProject = false
//    
//    var body: some View {
//        VStack(spacing: 20) {
//            
//            
//            VStack(spacing: 15) {
//                
//                HStack {
//                    Image("changePin")
//                    Text("Create New Project")
//                        .font(.title2).bold()
//                        .foregroundColor(.primary)
//                    Spacer()
//                    Button(action: { dismiss() }) {
////                        Image(systemName: "xmark.circle.fill")
////                            .font(.title2)
////                            .foregroundColor(.primary)
////                            .background(Color(hex: "ECEFFF"))
//
//                        Image("close")
//                            .background(Color(hex: "ECEFFF"))
//                            .clipShape(Circle())
//                    }
//                }
//                
//                Divider()
//                    .frame(maxWidth: .infinity, maxHeight: 1)
//                
//                CustomInputFieldProjectName(icon: "", placeholder: "Project Name", text: .constant(""))  //text: $viewModel.projectName)
//                    .padding(.vertical)
//                
//                LargeCustomInputFieldP(icon: "", placeholder: "Description", text: .constant(""))
//            }
//            .padding()
//            
//
//            ReusableButton(
//                title: "Continue",
//                foregroundColor: .white,
//                isDisabled: false,
//                action: {
//                    //viewModel.verifyOTP()
//                }
//            )
//            
//            HStack {
//                Text("Want to Add Complete Details? ")
//                    .foregroundColor(Color(.systemGray3))
//                
//                
////                VStack {
////                    ReusableButton(
////                        title: "View All Worklists  →",   //assign from own- save changes, if other then show View All Projects
////                        foregroundColor: .white,
////                        isDisabled: false,
////                        action: {
////                            viewModel.isNavigatingToDetails = true   //remove later with project
////                        }
////                    )
////                }
////                .padding()
//                
//                Button(action: navigateToCreateProject = true }) {
//                    Text("Click Here")
//                        .foregroundColor(.blue)
//                }
//                
//                
//               
//            }
//            .bold()
//            
//            Spacer()
//        }
//        .padding()
//        .background(Color(.systemBackground))
//        .clipShape(RoundedRectangle(cornerRadius: 40))
//    }
//}
