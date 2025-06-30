//
//  OfflineUserImpl.swift
//  user-manager
//
//  Created by Yuvraj Singh on 29/06/25.
//

import Foundation

public class OfflineUserImpl: OfflineUser, @unchecked Sendable {
    private var user: User
    private let onlineSync: OnlineSync
    private var future: RetryableFuture<Void>

    public init(user: User, onlineSync: OnlineSync) {
        self.user = user
        self.onlineSync = onlineSync
        self.future = RetryableFuture { }
        self.assignCallback()
    }

    private func assignCallback() {
        self.future = RetryableFuture<Void> {
            let newUser = try await self.onlineSync.getFuture().get()
            self.user = newUser
        }
    }

    public func syncFuture() -> RetryableFuture<Void> {
        return self.future
    }

    public func retrySync() {
        onlineSync.retry()
        assignCallback()
    }

    public var userId: String {
        return user.userId
    }

    public var email: String {
        return user.email
    }

    public var phoneNumber: PhoneNumber {
        return user.phoneNumber
    }

    public var apiKey: String {
        return user.apiKey
    }
}
