//
//  NewUserAuthenticator.swift
//  user-manager
//
//  Created by Yuvraj Singh on 29/06/25.
//

import Foundation

public class NewUserAuthenticator {
    private let context: AuthContext

    public init(context: AuthContext) {
        self.context = context
    }

    public func authenticate(userId: String) async throws -> User {
        let serverAuthenticator = ServerAuthenticator(authContext: context)
        let userData = try await serverAuthenticator.authenticate(userId: userId)
        
        let localUserManager = LocalUserManager(path: context.blockPath)
        try localUserManager.create(userData: userData)
        
        return UserImpl(userData: userData)
    }
}
