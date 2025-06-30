//
//  SignInRequest.swift
//  user-manager
//
//  Created by Yuvraj Singh on 27/06/25.
//

import Foundation

public struct SignInRequest: Codable {
    var userId: String
    var app: String
    var device: Device?
    
    public init() {
        self.userId = ""
        self.app = ""
        self.device = nil
    }
    
    public init(userId: String, app: String, device: Device) {
        self.userId = userId
        self.app = app
        self.device = device
    }
}
