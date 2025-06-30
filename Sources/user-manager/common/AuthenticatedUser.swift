//
//  AuthenticatedUser.swift
//  user-manager
//
//  Created by Yuvraj Singh on 26/06/25.
//

import Foundation

public struct AuthenticatedUser: Codable {
    let userId: String
    let emailId: String
    let phoneNumber: PhoneNumber
    let apiKey: String
}
