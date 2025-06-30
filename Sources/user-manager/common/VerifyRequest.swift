//
//  VerifyRequest.swift
//  user-manager
//
//  Created by Yuvraj Singh on 27/06/25.
//

import Foundation

public struct VerifyRequest: Codable {
    var sessionId: String
    var otp: Int

    public init(sessionId: String, otp: Int) {
        self.sessionId = sessionId
        self.otp = otp
    }
}
