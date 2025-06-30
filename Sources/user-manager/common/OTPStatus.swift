//
//  OTPStatus.swift
//  user-manager
//
//  Created by Yuvraj Singh on 27/06/25.
//

public enum OTPStatus : String, Codable, Sendable {
    case expired, incorrect, notFound, maxAttemptsReached
}
