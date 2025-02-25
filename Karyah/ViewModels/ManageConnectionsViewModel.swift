//
//  ManageConnectionsViewModel.swift
//  Karyah
//
//  Created by Prance Studio on 10/02/25.
//

import Foundation

class ManageConnectionsViewModel: ObservableObject {
    @Published var manageConnections: [ManageConnection] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    func fetchManageConnections() {
        guard let url = URL(string: "\(ConnectionBaseURL.url)/list") else {
            errorMessage = "Invalid URL"
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let token = TokenStorage.token  // ✅ Ensure this contains a valid token
        print("🔐 Token being sent: \(token)")

        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization") 
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        isLoading = true
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false
            }

            if let error = error {
                DispatchQueue.main.async {
                    self.errorMessage = "Error: \(error.localizedDescription)"
                }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async {
                    self.errorMessage = "No data received"
                }
                return
            }

            // ✅ Debug: Print full API response
            if let jsonString = String(data: data, encoding: .utf8) {
                print("🌍 API Response: \(jsonString)")
            }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let decodedResponse = try decoder.decode(ConnectionResponse.self, from: data)

                DispatchQueue.main.async {
                    self.manageConnections = decodedResponse.connections
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = "Decoding error: \(error.localizedDescription)"
                    print("❌ Decoding Error: \(error)")
                }
            }
        }.resume()
    }

}
