//
//  UserAuthenticator.swift
//  user-manager
//
//  Created by Yuvraj Singh on 29/06/25.
//

import Foundation

public final class UserAuthenticator {
    private let context: AuthContext

    public init(context: AuthContext) {
        self.context = context
    }

    public func authenticate(userId: String) async throws -> User {
        let localManager = LocalUserManager(path: context.blockPath)

        if localManager.exists(userId: userId) {
            let existingAuthenticator = ExistingUserAuthenticator(context: context)
            return try existingAuthenticator.authenticate(userId: userId)
        } else {
            let newAuthenticator = NewUserAuthenticator(context: context)
            return try await newAuthenticator.authenticate(userId: userId)
        }
    }
}
