//
//  OnlineSyncImpl.swift
//  user-manager
//
//  Created by Yuvraj Singh on 29/06/25.
//

import Foundation

public class OnlineSyncImpl: OnlineSync {
    private let authContext: AuthContext
    private let userData: UserData
    private var future: RetryableFuture<User>

    public init(userData: UserData, authContext: AuthContext) {
        self.userData = userData
        self.authContext = authContext
        self.future = Self.signIn(userData: userData, authContext: authContext)
    }

    private static func signIn(userData: UserData, authContext: AuthContext) -> RetryableFuture<User> {
        return RetryableFuture<User> {
            let serverAuthenticator = ServerAuthenticator(authContext: authContext)
            let newUserData = try await serverAuthenticator.authenticate(userId: userData.userId)
            try updateLocalUser(newUser: newUserData, blockPath: authContext.blockPath)
            return UserImpl(userData: newUserData)
        }
    }

    private static func updateLocalUser(newUser: UserData, blockPath: URL) throws {
        let localUserManager = LocalUserManager(path: blockPath)
        try localUserManager.update(userData: newUser)
    }

    public func getFuture() -> RetryableFuture<User> {
        return future
    }

    public func retry() {
        self.future = Self.signIn(userData: userData, authContext: authContext)
    }
}
