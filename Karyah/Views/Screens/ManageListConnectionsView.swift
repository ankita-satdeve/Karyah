//
//  ManageConnectionsView.swift
//  Karyah
//
//  Created by Prance Studio on 10/02/25.
//

import SwiftUI

struct ManageConnectionsView: View {
    @StateObject private var viewModel = ManageConnectionsViewModel()
    @State private var navigateToAddConnection = false

    var body: some View {
        NavigationView {
            VStack {
                // Header Section with Add Button
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(LinearGradient(gradient: Gradient(colors: [
                            Color(hex: "#C6381E"),
                            Color(hex: "#9E240F")
                        ]), startPoint: .bottomTrailing, endPoint: .topLeading))
                        .frame(height: 131)
                        .padding(.horizontal)
                    
                    VStack(alignment: .leading) {
                        Text("Manage Connections")
                            .font(.title.bold())
                        Text("Total Connections: \(viewModel.manageConnections.count)")
                            .padding(.top, -5)
                    }
                    .foregroundColor(Color(UIColor.systemBackground))
                    
                    // Add Connections Button
                    HStack {
                        Spacer()
                        Button(action: {
                            navigateToAddConnection = true
                        }) {
                            HStack {
                                Text("Add Connections")
                                Image(systemName: "plus")
                            }
                        }
                        .padding(.trailing, 20)
                        .padding(.top, 100)
                        .foregroundColor(.white)
                    }
                }
                .padding(.top, 10)
                .navigationDestination(isPresented: $navigateToAddConnection) {
                    AddConnectionsView()
                }
                
                

                // Loading, Error, and Connection List
                if viewModel.isLoading {
                    ProgressView("Loading...")
                        .padding()
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                } else {
                    List(viewModel.manageConnections) { connection in
                        HStack {
                            Image("Profile")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.gray)
                                .accessibilityHidden(true)
                            
                            VStack(alignment: .leading) {
                                Text(connection.name)
                                    .font(.headline)
                                Text(connection.email)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                        
                    }
                }
            }
            .navigationTitle("Connections")
            .navigationBarTitleDisplayMode(.inline)
            .background(Color(UIColor.systemBackground).edgesIgnoringSafeArea(.all))
            .onAppear {
                viewModel.fetchManageConnections()
            }
        }
    }
}


struct ManageConnectionsView_Previews: PreviewProvider {
    static var previews: some View {
        ManageConnectionsView()
            .previewDevice("iPhone 16 Pro")
    }
}

