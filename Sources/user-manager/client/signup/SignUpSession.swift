//
//  SignUpSession.swift
//  user-manager
//
//  Created by Yuvraj Singh on 28/06/25.
//

import Foundation

public protocol SignUpSession : Sendable {
    func sendOTP() async throws
    func signUp(otp: Int) async throws -> User
}
