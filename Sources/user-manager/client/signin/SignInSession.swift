//
//  SignInSession.swift
//  user-manager
//
//  Created by Yuvraj Singh on 29/06/25.
//

public protocol SignInSession: Sendable {
    func sendOTP() async throws
    func verifyOTP(otp: Int) async throws
    func getVerifyResponse() -> VerifyResponse?
}
