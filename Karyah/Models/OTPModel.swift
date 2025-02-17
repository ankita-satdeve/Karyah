//
//  OTPModel.swift
//  Demo_Login
//
//  Created by Prance Studio on 11/02/25.
//

import Foundation

struct OTPModel: Codable {
    var phoneEmail: String = ""
    var otp: String = ""
    var timer: Int = 60
    var isOTPSent: Bool = false
    var canResend: Bool = false
    var errorMessage: String? = nil
    var isRegistered: Bool = false

    // Map phoneEmail to email in the JSON
    enum CodingKeys: String, CodingKey {
        case phoneEmail = "email"
        case otp
        case timer
        case isOTPSent
        case canResend
        case errorMessage
    }
}
struct OTPResponse: Decodable {
    let message: String
    let isRegistered: Bool
}

struct VerifyOTPResponse: Decodable {
    let token: String
}
