//
//  ExistingUserAuthenticator.swift
//  user-manager
//
//  Created by Yuvraj Singh on 29/06/25.
//

import Foundation

public final class ExistingUserAuthenticator {
    private let context: AuthContext

    public init(context: AuthContext) {
        self.context = context
    }

    public func authenticate(userId: String) throws -> OfflineUser {
        let userData = try getUser(userId: userId)
        let user = UserImpl(userData: userData)
        let onlineSync = OnlineSyncImpl(userData: userData, authContext: context)
        return OfflineUserImpl(user: user, onlineSync: onlineSync)
    }

    private func getUser(userId: String) throws -> UserData {
        let localUserManager = LocalUserManager(path: context.blockPath)
        return try localUserManager.get(userId: userId)
    }
}
