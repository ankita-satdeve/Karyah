//
//  Connection.swift
//  Karyah
//
//  Created by apple on 03/02/25.
//

import SwiftUI

struct Connection: Identifiable, Codable {
    let id: Int
    let name: String?
    let email: String
    let phone: String?
    let location: String?
    let bio: String?
    let dob: String?
    let pin: String?
    let profilePhoto: String?
    let createdAt: String
    let updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id = "userId"
        case name
        case email
        case phone
        case location
        case bio
        case dob
        case pin
        case profilePhoto
        case createdAt
        case updatedAt
    }
}
