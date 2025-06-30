//
//  SignInSessionImpl.swift
//  user-manager
//
//  Created by Yuvraj Singh on 29/06/25.
//

import Foundation

public class SignInSessionImpl: SignInSession , @unchecked Sendable {
    private let client: SignInClient
    private let contact: Contact
    private var sessionId: String = ""
    private var verifyResponse: VerifyResponse?

    public init(context: AuthContext, contact: Contact) {
        self.client = SignInClient(baseUrl: context.userUrl())
        self.contact = contact
    }

    public func sendOTP() async throws {
        let sessionResponse = try await client.sendOTP(contact: contact)
        self.sessionId = sessionResponse.sessionId
    }

    public func verifyOTP(otp: Int) async throws {
        let request = VerifyRequest(sessionId: sessionId, otp: otp)
        let response = try await client.verifyOTP(request: request)
        self.verifyResponse = response
    }

    public func getVerifyResponse() -> VerifyResponse? {
        return self.verifyResponse
    }
}
