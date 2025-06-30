//
//  UserManager.swift
//  user-manager
//
//  Created by Yuvraj Singh on 30/06/25.
//

import Foundation

public protocol UserManager : Sendable {
    func createSignUpSession(contact: Contact) -> SignUpSession

    func createSignInSession(contact: Contact) -> SignInSession

    func offlineSignIn(userId: String) throws -> OfflineUser

    func signIn(userId: String) async throws -> User

//    func getProfileManager(for user: User) -> ProfileManager
//
//    func getProfile(userId: String) -> Profile

    func getUrls() -> [String: String]

//    func recentAccounts() -> [String]
}
