//
//  UserData.swift
//  user-manager
//
//  Created by Yuvraj Singh on 28/06/25.
//

import Foundation

public struct UserData: Codable, Sendable {
    var userId: String
    var emailId: String
    var phoneNumber: PhoneNumber
    var apiKey: String

    // Memberwise initializer (equivalent to @AllArgsConstructor)
    public init(userId: String, emailId: String, phoneNumber: PhoneNumber, apiKey: String) {
        self.userId = userId
        self.emailId = emailId
        self.phoneNumber = phoneNumber
        self.apiKey = apiKey
    }
}
