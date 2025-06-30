//
//  ServerAuthenticator.swift
//  user-manager
//
//  Created by Yuvraj Singh on 29/06/25.
//

import Foundation

public class ServerAuthenticator {
    private let authConfig: AuthConfig
    private let signInClient: SignInClient

    public init(authContext: AuthContext) {
        self.authConfig = authContext.authConfig
        self.signInClient = SignInClient(baseUrl: authContext.userUrl())
    }

    public func authenticate(userId: String) async throws -> UserData {
        let request = SignInRequest(
            userId: userId,
            app: authConfig.app.rawValue,
            device: authConfig.device
        )

        let user = try await signInClient.signIn(request: request)

        return UserData(
            userId: user.userId,
            emailId: user.emailId,
            phoneNumber: user.phoneNumber,
            apiKey: user.apiKey
        )
    }
}
