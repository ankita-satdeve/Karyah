//
//  PINModel.swift
//  Demo_Login
//
//  Created by Prance Studio on 12/02/25.
//

import Foundation

struct PINModel: Codable {
    var phoneEmail: String = ""
    var pin: String = ""
    var errorMessage: String? = nil

    // Map phoneEmail to email in the JSON
    enum CodingKeys: String, CodingKey {
        case phoneEmail = "email"
    }
}

struct LoginResponse: Codable {
    let token: String
}
