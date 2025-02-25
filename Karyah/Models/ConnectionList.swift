//
//  Connection.swift
//  Karyah
//
//  Created by Prance Studio on 19/02/25.
//

import Foundation

struct ConnectionList: Identifiable, Codable {
    let id = UUID()
    let connectionId: Int
    let userId: Int
    let name: String
    let email: String?
    let phone: String?
    let location: String?
    let dob: String?
    let bio: String?
    let profilePhoto: String?
    
    enum CodingKeys: String, CodingKey {
        case connectionId, userId, name, email, phone, location, dob, bio, profilePhoto
    }
}

struct ConnectionListResponse: Codable {
    let connections: [ConnectionList]
}
