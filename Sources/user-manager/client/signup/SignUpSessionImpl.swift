//
//  SignUpSessionImpl.swift
//  user-manager
//
//  Created by Yuvraj Singh on 28/06/25.
//

import Foundation

public class SignUpSessionImpl: SignUpSession, @unchecked Sendable {
    private let client: SignUpClient
    private let userCreator: UserCreator
    private let contact: Contact
    private var sessionId: String = ""
    private let onSignUp: (User) -> Void

    public init(context: AuthContext, contact: Contact, onSignUp: @escaping (User) -> Void) {
        self.client = SignUpClient(baseUrl: context.userUrl())
        self.userCreator = UserCreator(client: client, context: context)
        self.contact = contact
        self.onSignUp = onSignUp
    }

    public func sendOTP() async throws {
        if let email = contact.emailId {
            self.sessionId = try await client.sendOTP(emailId: email)
        } else if let phone = contact.phoneNumber {
            self.sessionId = try await client.sendOTP(phoneNumber: phone)
        } else {
            throw BadRequestError(message: "Contact must have either email or phone number")
        }
    }

    public func signUp(otp: Int) async throws -> User {
        let user = try await userCreator.create(contact: contact, sessionId: sessionId, otp: otp)
        onSignUp(user)
        return user
    }
}
