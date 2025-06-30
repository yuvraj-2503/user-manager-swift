//
//  UserImpl.swift
//  user-manager
//
//  Created by Yuvraj Singh on 28/06/25.
//

import Foundation

public struct UserImpl: User {
    private let userData: UserData

    public var userId: String {
        return userData.userId
    }

    public var email: String {
        return userData.emailId
    }

    public var phoneNumber: PhoneNumber {
        return userData.phoneNumber
    }

    public var apiKey: String {
        return userData.apiKey
    }

    public init(userData: UserData) {
        self.userData = userData
    }
}
