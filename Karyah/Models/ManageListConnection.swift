//
//  ManageConnection.swift
//  Karyah
//
//  Created by Prance Studio on 10/02/25.
//

import Foundation

struct ConnectionResponse: Codable {
    let connections: [ManageConnection]
}

struct ManageConnection: Identifiable, Codable {
    let id: Int
    let name: String
    let email: String
    let phone: String
    let location: String
    let dob: String?
    let bio: String?
    let profilePhoto: String?

    enum CodingKeys: String, CodingKey {
        case id = "userId"
        case name, email, phone, location, dob, bio, profilePhoto
    }
}
