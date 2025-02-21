//
//  ConnectionViewModel.swift
//  Karyah
//
//  Created by Prance Studio on 19/02/25.
//


import SwiftUI
import Alamofire

class ConnectionViewModel: ObservableObject {
    @Published var connections: [Connection] = []
    @Published var filteredConnections: [Connection] = []
    @Published var isDropdownVisible = false
    @Published var searchText = ""
    
    let apiUrl = "\(BaseURL.url)/connections"

    func fetchManageConnections() {
        let url = "\(apiUrl)/list"

        guard let token = UserDefaults.standard.string(forKey: "userToken") else {
            print("Token not found")
            return
        }

        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)",
            "Content-Type": "application/json"
        ]

        AF.request(url, method: .get, headers: headers).responseDecodable(of: ConnectionResponse.self) { response in
            DispatchQueue.main.async {
                switch response.result {
                case .success(let data):
                    self.connections = data.connections
                    self.filteredConnections = data.connections
                case .failure(let error):
                    print("❌ API Error: \(error.localizedDescription)")
                }
            }
        }
    }

    func filterConnections() {
        if searchText.isEmpty {
            filteredConnections = connections
        } else {
            filteredConnections = connections.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
}

