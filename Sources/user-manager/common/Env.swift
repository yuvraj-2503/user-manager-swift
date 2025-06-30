//
//  Env.swift
//  user-manager
//
//  Created by Yuvraj Singh on 27/06/25.
//

public enum Env: String, Codable, Sendable {
    case production = "PRODUCTION"
    case development = "DEVELOPMENT"
    case local = "LOCAL"
}
