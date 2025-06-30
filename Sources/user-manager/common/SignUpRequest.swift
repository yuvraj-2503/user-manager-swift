//
//  SignUpRequest.swift
//  user-manager
//
//  Created by Yuvraj Singh on 26/06/25.
//

import Foundation

public struct SignUpRequest: Codable {
    var emailId: String?
    var phoneNumber: PhoneNumber?
    var otp: Int
    var sessionId: String
    var device: Device?
    var app: String
    
    init() {
        self.app = ""
        self.device = nil
        self.emailId = nil
        self.phoneNumber = nil
        self.otp = 0
        self.sessionId = ""
    }
}
