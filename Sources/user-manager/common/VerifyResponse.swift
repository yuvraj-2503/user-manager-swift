//
//  VerifyResponse.swift
//  user-manager
//
//  Created by Yuvraj Singh on 27/06/25.
//

import Foundation

public struct VerifyResponse: Codable {
    var userId: String
    var token: String

    public init(userId: String, token: String) {
        self.userId = userId
        self.token = token
    }
    
    public func getUserId() -> String {
        return userId
    }
}
