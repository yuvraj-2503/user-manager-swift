//
//  UserCreator.swift
//  user-manager
//
//  Created by Yuvraj Singh on 28/06/25.
//

import Foundation

public class UserCreator {
    private let client: SignUpClient
    private let context: AuthContext

    public init(client: SignUpClient, context: AuthContext) {
        self.client = client
        self.context = context
    }

    public func create(contact: Contact, sessionId: String, otp: Int) async throws -> User {
        let authenticatedUser = try await signUp(contact: contact, sessionId: sessionId, otp: otp)
        let userData = getUserData(from: authenticatedUser)
        let localUserManager = LocalUserManager(path: context.blockPath)
        try localUserManager.create(userData: userData)
        return UserImpl(userData: userData)
    }

    private func getUserData(from user: AuthenticatedUser) -> UserData {
        return UserData(
            userId: user.userId,
            emailId: user.emailId,
            phoneNumber: user.phoneNumber,
            apiKey: user.apiKey
        )
    }

    private func signUp(contact: Contact, sessionId: String, otp: Int) async throws -> AuthenticatedUser {
        let config = context.authConfig
        var signUpRequest = SignUpRequest()
        signUpRequest.emailId = contact.emailId
        signUpRequest.phoneNumber = contact.phoneNumber
        signUpRequest.sessionId = sessionId
        signUpRequest.otp = otp
        signUpRequest.app = context.app.rawValue
        signUpRequest.device = config.device
        return try await client.signUp(signUpRequest: signUpRequest)
    }
}
