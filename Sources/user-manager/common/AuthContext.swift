//
//  AuthContext.swift
//  user-manager
//
//  Created by Yuvraj Singh on 27/06/25.
//

import Foundation

public struct AuthContext: Codable, Sendable {
    let blockPath: URL
    let authConfig: AuthConfig
    let urls: [String: String]
    let app: App

    public func userUrl() -> String {
        return urls[ServerKeys.userServer]!
    }
}
