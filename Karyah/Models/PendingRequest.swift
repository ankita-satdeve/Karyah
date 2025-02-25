//
//  PendingRequest.swift
//  Karyah
//
//  Created by Prance Studio on 10/02/25.
//

struct PendingRequestResponse: Codable {
    let pendingRequests: [PendingRequest]
}

struct PendingRequest: Identifiable, Codable {
    let id: Int
    let requesterId: Int
    let recipientId: Int
    let status: String
    let createdAt: String
    let updatedAt: String
    let requester: UserConnection
    let recipient: UserConnection
    
    // Replace 'id' with 'connectionId' in your app logic
    var connectionId: Int { id }    
}

struct UserConnection: Codable {
    let userId: Int
    let name: String
    let email: String
}
