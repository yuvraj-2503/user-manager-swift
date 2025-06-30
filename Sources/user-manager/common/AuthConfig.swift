//
//  AuthConfig.swift
//  user-manager
//
//  Created by Yuvraj Singh on 27/06/25.
//

import Foundation

public struct AuthConfig: Codable, Sendable {
    let app: App
    let device: Device
    let locatorUrl: String
    let env: Env
    
    public init(app: App, device: Device, locatorUrl: String, env: Env) {
        self.app = app
        self.device = device
        self.locatorUrl = locatorUrl
        self.env = env
    }
}
