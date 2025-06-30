//
//  OnlineSync.swift
//  user-manager
//
//  Created by Yuvraj Singh on 29/06/25.
//

import Foundation

public protocol OnlineSync {
    func getFuture() -> RetryableFuture<User>
    func retry()
}
