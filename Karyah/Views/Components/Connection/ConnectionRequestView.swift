//
//  ConnectionRequestView.swift
//  Karyah
//
//  Created by Prance Studio on 07/02/25.
//

import SwiftUI

struct ConnectionRequestView: View {
    @State private var isLoading = false
    @State private var errorMessage: String?

    var body: some View {
        VStack {
            HStack {
                // Profile Picture
                Image("profile")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    .foregroundColor(.gray)
                
                // Invitation Details
                VStack(alignment: .leading) {
                    Text("Anki invited you to the Karyah community !")
                        .font(.headline)
                        .multilineTextAlignment(.leading)
                    HStack {
                        Image(systemName: "network")
                            .foregroundColor(.green)
                        Text("Connection • 4 minutes ago")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
                
                Spacer()
            }
            .padding()

            // Action Buttons
            HStack {
                // Decline Button
                Button(action: rejectConnection) {
                    Text("Decline")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(Color(.systemGray2))
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray, lineWidth: 1)
                                .frame(width: .infinity, height: 40, alignment: .center)
                        )
                }
                .disabled(isLoading)

                // Accept Button
                Button(action: acceptConnection) {
                    Text("Accept")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
//                        .background(isLoading ? Color.gray : Color.red)
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
                        .frame(width: .infinity, height: 40, alignment: .center)
                        .cornerRadius(10)
                }
                
                .disabled(isLoading)
            }
            .padding(.horizontal)
            
            // Error Message
            if let errorMessage = errorMessage {
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

    // Accept Connection Request API Call
    func acceptConnection() {
        isLoading = true
        errorMessage = nil

        let url = URL(string: "https://api.karyah.in/api/connections/accept-request")!
        
        // Retrieve token from UserDefaults
        guard let token = UserDefaults.standard.string(forKey: "userToken") else {
            DispatchQueue.main.async {
                self.errorMessage = "No authentication token found!"
                self.isLoading = false
            }
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        let body: [String: Any] = ["requesterId": 14]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                isLoading = false
                if let error = error {
                    errorMessage = "❌ Request failed: \(error.localizedDescription)"
                    return
                }
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                    print("✅ Connection Accepted Successfully!")
                } else {
                    errorMessage = "❌ Failed to accept request."
                }
            }
        }.resume()
    }

    // Reject Connection Request API Call
    func rejectConnection() {
        isLoading = true
        errorMessage = nil

        let url = URL(string: "https://api.karyah.in/api/connections/reject-request")!
        
        guard let token = UserDefaults.standard.string(forKey: "userToken") else {
            DispatchQueue.main.async {
                self.errorMessage = "No authentication token found!"
                self.isLoading = false
            }
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        let body: [String: Any] = ["requesterId": 14]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                isLoading = false
                if let error = error {
                    errorMessage = "❌ Request failed: \(error.localizedDescription)"
                    return
                }
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                    print("✅ Connection Rejected Successfully!")
                } else {
                    errorMessage = "❌ Failed to reject request."
                }
            }
        }.resume()
    }
}

// Preview
struct ConnectionRequestView_Previews: PreviewProvider {
    static var previews: some View {
        ConnectionRequestView()
            .background(Color(UIColor.systemGroupedBackground))
    }
}
