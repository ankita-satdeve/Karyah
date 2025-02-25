//
//  PendingRequestView.swift
//  Karyah
//
//  Created by Prance Studio on 10/02/25.


import SwiftUI

struct PendingRequestView: View {
    @StateObject private var viewModel = PendingRequestViewModel()
    let token = UserDefaults.standard.string(forKey: "userToken")
    
    var body: some View {
        NavigationStack {
            VStack {
                // Header
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(LinearGradient(gradient: Gradient(colors: [
                            Color(hex: "#C6381E"),
                            Color(hex: "#9E240F")
                        ]), startPoint: .bottomTrailing, endPoint: .topLeading))
                        .frame(height: 131)
                        .padding(.horizontal)
                    
                    Text("Pending Requests")
                        .font(.title.bold())
                        .foregroundColor(.white)
                }
                
                if viewModel.isLoading {
                    ProgressView("Loading...")
                        .padding()
                } else if let errorMessage = viewModel.errorMessage {
                    VStack {
                        Image(systemName: "exclamationmark.triangle")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.red)
                            .padding(.bottom, 10)
                        
                        Text(errorMessage)
                            .font(.headline)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                } else if viewModel.pendingRequests.isEmpty {
                    VStack {
                        Image(systemName: "person.badge.shield.exclamationmark.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.green)
                            .padding(.bottom, 10)
                        
                        Text("No Pending Requests")
                            .font(.headline)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                } else {
                    // Display Pending Requests List
                    List(viewModel.pendingRequests) { request in
                        VStack(alignment: .leading) {
                            HStack(alignment: .top, spacing: 12) {
                                Image("profile")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                                    .foregroundColor(.gray)

                                VStack(alignment: .leading, spacing: 4) {
                                    Text("\(request.requester.name) invited you to the Karyah community!")
                                        .font(.headline)
                                        .multilineTextAlignment(.leading)

                                    HStack(spacing: 4) {
                                        Image(systemName: "network")
                                            .foregroundColor(.green)
                                        Text("Connection • 4 minutes ago")
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                    }
                                }
                            }
                            .padding()

                            Spacer()

//                            Text("Pending")
//                                .font(.caption)
//                                .foregroundColor(.orange)
                            
                            // Action Buttons
                            HStack {
                                Button(action: { rejectConnection(connectionId: request.connectionId) }) {
                                    Text("Decline")
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .foregroundColor(Color(.systemGray2))
                                        .background(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(Color.gray, lineWidth: 1)
                                                .frame(height: 40)
                                        )
                                }
                                .disabled(viewModel.isLoading)

                                Button(action: { acceptConnection(connectionId: request.connectionId) }) {
                                    Text("Accept")
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .foregroundColor(.white)
                                        .background(
                                            LinearGradient(
                                                gradient: Gradient(colors: [
                                                    Color(hex: "#C6381E"),
                                                    Color(hex: "#9E240F")
                                                ]),
                                                startPoint: .trailing,
                                                endPoint: .leading
                                            )
                                        )
                                        .frame(height: 40)
                                        .cornerRadius(10)
                                }
                                .disabled(viewModel.isLoading)
                            }
                            .padding(.horizontal)

                            if let errorMessage = viewModel.errorMessage {
                                Text(errorMessage)
                                    .foregroundColor(.red)
                                    .font(.footnote)
                                    .padding(.top, 5)
                            }
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color(UIColor.systemBackground))
                                .shadow(color: .gray.opacity(0.2), radius: 10, x: 0, y: 5)
                        )
                        .padding()
                    }
                }
            }
            .onAppear {
                viewModel.fetchPendingRequests()
            }
            .navigationTitle("Pending Requests")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    // Accept Connection Request API Call
    func acceptConnection(connectionId: Int) {
        viewModel.isLoading = true
        viewModel.errorMessage = nil

        let url = URL(string: "https://api.karyah.in/api/connections/accept-request")!
        // Retrieve token from UserDefaults
        let token = UserDefaults.standard.string(forKey: "userToken")
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(String(describing: token))", forHTTPHeaderField: "Authorization")

        let body: [String: Any] = ["connectionId": connectionId]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                viewModel.isLoading = false
                if let error = error {
                    viewModel.errorMessage = "❌ Request failed: \(error.localizedDescription)"
                    return
                }
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                    print("✅ Connection Accepted Successfully!")
                    viewModel.fetchPendingRequests()
                } else {
                    viewModel.errorMessage = "❌ Failed to accept request."
                }
            }
        }.resume()
    }

    // Reject Connection Request API Call
    func rejectConnection(connectionId: Int) {
        viewModel.isLoading = true
        viewModel.errorMessage = nil
        let token = UserDefaults.standard.string(forKey: "userToken")
        let url = URL(string: "https://api.karyah.in/api/connections/reject-request")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(String(describing: token))", forHTTPHeaderField: "Authorization")

        let body: [String: Any] = ["connectionId": connectionId]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                viewModel.isLoading = false
                if let error = error {
                    viewModel.errorMessage = "❌ Request failed: \(error.localizedDescription)"
                    return
                }
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                    print("✅ Connection Rejected Successfully!")
                    viewModel.fetchPendingRequests()
                } else {
                    viewModel.errorMessage = "❌ Failed to reject request."
                }
            }
        }.resume()
    }
}

#Preview {
    PendingRequestView()
}
