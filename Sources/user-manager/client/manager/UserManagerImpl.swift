//
//  UserManagerImpl.swift
//  user-manager
//
//  Created by Yuvraj Singh on 30/06/25.
//

import Foundation

public class UserManagerImpl: UserManager, @unchecked Sendable {
    private let authContext: AuthContext
//    private let recentsManager: RecentsManager

    public init(path: URL, authConfig: AuthConfig) async throws {
        let urls = try await URLManager(locatorUrl: authConfig.locatorUrl, path: path, env: authConfig.env).getUrl()
        self.authContext = AuthContext(blockPath: path, authConfig: authConfig, urls: urls, app: authConfig.app)
//        self.recentsManager = RecentsManager(blockPath: authContext.blockPath)
    }

    public func createSignUpSession(contact: Contact) -> SignUpSession {
        return SignUpSessionImpl(context: authContext, contact: contact, onSignUp: onSignIn)
    }

    public func createSignInSession(contact: Contact) -> SignInSession {
        return SignInSessionImpl(context: authContext, contact: contact)
    }

    public func offlineSignIn(userId: String) throws -> OfflineUser {
        guard exists(userId: userId) else {
//            recentsManager.remove(userId: userId)
            throw NotFoundError(message: "Local User Not Found.")
        }
        let authenticator = ExistingUserAuthenticator(context: authContext)
        let user = try authenticator.authenticate(userId: userId)
        onSignIn(user)
        return user
    }

    public func signIn(userId: String) async throws -> User {
        let authenticator = UserAuthenticator(context: authContext)
        let user = try await authenticator.authenticate(userId: userId)
        onSignIn(user)
        return user
    }

    private func onSignIn(_ user: User) {
//        recentsManager.update(userId: user.userId)
    }

    private func exists(userId: String) -> Bool {
        return LocalUserManager(path: authContext.blockPath).exists(userId: userId)
    }

//    func getProfileManager(for user: User) -> ProfileManager {
//        let localProfileIO = LocalProfileIOImpl(userId: user.userId, path: authContext.blockPath)
//        return ProfileManagerImpl(userUrl: authContext.userUrl, apiKey: user.apiKey, localIO: localProfileIO)
//    }
//
//    func getProfile(userId: String) -> Profile {
//        return LocalProfileRetriever(path: authContext.blockPath).getProfile(userId: userId)
//    }

    public func getUrls() -> [String: String] {
        return authContext.urls
    }

//    func recentAccounts() -> [String] {
//        return recentsManager.get()
//    }
}
