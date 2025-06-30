//
//  OfflineUser.swift
//  user-manager
//
//  Created by Yuvraj Singh on 29/06/25.
//

import Foundation

public protocol OfflineUser: User {
    func syncFuture() -> RetryableFuture<Void>
    func retrySync()
}
