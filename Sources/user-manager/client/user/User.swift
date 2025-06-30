//
//  User.swift
//  user-manager
//
//  Created by Yuvraj Singh on 28/06/25.
//

import Foundation

public protocol User: Sendable {
    var userId: String { get }
    var email: String { get }
    var phoneNumber: PhoneNumber { get }
    var apiKey: String { get }
}
