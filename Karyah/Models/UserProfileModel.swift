//
//  UserProfileModel.swift
//  Karyah
//
//  Created by Prance Studio on 14/02/25.
//
import Foundation
import SwiftUI
import Combine

struct UserProfileResponse: Codable {
    var user: UserProfileModel
}

struct UserProfileModel: Codable {
    var userId: Int
    var email: String
    var name: String
    var phone: String
    var location: String
    var dob: String?
    var pin: String
    var bio: String
    var profilePhoto: String?
    var createdAt: String
    var updatedAt: String
}
