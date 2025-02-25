//
//  AddConnectionsView.swift
//  Karyah
//
//  Created by apple on 05/02/25.
//

import SwiftUI

struct AddConnectionsView: View {
    @StateObject private var viewModel = AddConnectionsViewModel()
    @State private var navigateToPendingRequest = false
    @State private var requestSent = false
    
    var body: some View {
        NavigationStack {
            VStack {
                
                Button(action: {
                    navigateToPendingRequest = true
                }) {
                    HStack {
                        Image(systemName: "plus")
                            .padding(.leading, 200)
                        Text("Pending Requests")
                    }
                }
                .navigationDestination(isPresented: $navigateToPendingRequest) {
                    PendingRequestView()
                }
                
                // Header Section
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(LinearGradient(gradient: Gradient(colors: [
                            Color(hex: "#C6381E"),
                            Color(hex: "#9E240F")
                        ]), startPoint: .bottomTrailing, endPoint: .topLeading))
                        .frame(height: 131)
                        .padding(.horizontal)
                    
                    Text("Add Connections")
                        .font(.title.bold())
                        .foregroundColor(.white)
                }
                
                
                
                // Search Bar
                HStack {
                    TextField("Search Connection", text: $viewModel.searchText, onCommit: {
                        viewModel.searchConnections()
                    })
                    .padding(.leading, 30) // Add padding to make space for the magnifying glass
                    .padding()
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(10)
                    .overlay(
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.primary)
                                .padding(.leading, 15) // Adjust position of the icon
                            Spacer()
                        }
                    )
                    .padding(.horizontal)
                    .accessibilityLabel("Search Connection")
                    .submitLabel(.search)
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
                    List(viewModel.connections) { connection in
                        HStack {
                            Image("profile")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.gray)
                                .accessibilityHidden(true)
                            
                            VStack(alignment: .leading) {
                                Text(connection.name ?? "null")
                                    .font(.headline)
                                Text(connection.email)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                
                            }
                            Spacer()
                            Button(action: {
                                // Add connection action
                                let token =  UserDefaults.standard.string(forKey: "userToken")
                                
                                let recipientId = connection.id
                                
                                
                                addNewConnection(recipientId: recipientId, token: token ?? "invalid token")
                                requestSent = true
                            }) {
                                Text(requestSent ? "Request Sent" : "ADD")
                                    .foregroundColor(.white)
                                    .padding(.horizontal)
                                    .padding(.vertical, 6)
                                    .background(LinearGradient(gradient: Gradient(colors: requestSent ? [Color.gray, Color.gray] : [Color(hex: "#C6381E"), Color(hex: "#9E240F")]), startPoint: .bottomTrailing, endPoint: .topLeading))
                                    .cornerRadius(10)
                                .accessibilityLabel(requestSent ? "Request Sent to \(connection.name)" : "Add \(connection.name)")                            }
                            Image(systemName: "x.circle")
                                .foregroundColor(.primary)
                                .background(Color.clear)
                        }
                        .disabled(requestSent)
                    }
                }
            }
//            .navigationTitle("Connections")
            .navigationBarTitleDisplayMode(.inline)
            .background(Color(UIColor.systemBackground).edgesIgnoringSafeArea(.all))
        }
    }
}

func addNewConnection(recipientId: Int, token: String) {
    // API endpoint URL
    guard let url = URL(string: "https://api.karyah.in/api/connections/send-request") else { return }
    
    // Prepare the request body
    let requestBody = AddConnectionRequest(recipientId: recipientId)
    
    // Convert the request body to JSON
    guard let jsonData = try? JSONEncoder().encode(requestBody) else {
        print("Failed to encode JSON")
        return
    }
    
    // Create the URLRequest
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    request.httpBody = jsonData
    
    // Perform the API request
    URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            print("Error: \(error.localizedDescription)")
            return
        }
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            print("Server error or invalid response.")
            return
        }
        
        if let data = data {
            // Handle successful response
            print("Response Data: \(String(data: data, encoding: .utf8) ?? "No data")")
        }
    }.resume()
}


#Preview {
    AddConnectionsView()
}
