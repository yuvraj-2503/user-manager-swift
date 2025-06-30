//
//  SignInClient.swift
//  user-manager
//
//  Created by Yuvraj Singh on 28/06/25.
//

import Foundation
import rest_client_api
import util

public class SignInClient {
    private let baseUrl: String
    private let restClient: RestClientAsync = UrlSessionRestClientAsync()
    private let json: Json = DefaultJson()
    
    public init(baseUrl: String) {
        self.baseUrl = baseUrl
    }

    public func sendOTP(contact: Contact) async throws -> SessionResponse {
        let url = Url(baseUrl: baseUrl, pathParams: "auth", "send", "otp")
        let request = try BodyRequest(url: url, body: contact)
        let response: HttpResponse = try await restClient.post(request: request)

        let payload = response.payload
        let exceptionMessage = exceptionMessage(payload: payload)
        switch response.statusCode {
        case 200:
            return try json.decode(payload, as: SessionResponse.self)
        case 400:
            throw BadRequestError(message: exceptionMessage)
        case 404:
            throw NotFoundError(message: exceptionMessage)
        default:
            throw InternalError(message: exceptionMessage)
        }
    }

    public func verifyOTP(request: VerifyRequest) async throws -> VerifyResponse {
        let url = Url(baseUrl: baseUrl, pathParams: "auth", "verify", "otp")
        let requestBody = try BodyRequest(url: url, body: request)
        let response: HttpResponse = try await restClient.post(request: requestBody)

        let payload = response.payload
        let exceptionMessage = exceptionMessage(payload: payload)
        switch response.statusCode {
        case 200:
            return try json.decode(payload, as: VerifyResponse.self)
        case 400:
            throw BadRequestError(message: exceptionMessage)
        case 429:
            throw OTPError(otpStatus: .maxAttemptsReached)
        case 404:
            throw OTPError(otpStatus: .notFound)
        case 401:
            let result = try json.decode(payload, as: Result.self)
            if result.code == "otp-expired" {
                throw OTPError(otpStatus: .expired)
            } else {
                throw OTPError(otpStatus: .incorrect)
            }
        default:
            throw InternalError(message: exceptionMessage)
        }
    }

    public func signIn(request: SignInRequest) async throws -> AuthenticatedUser {
        let url = Url(baseUrl: baseUrl, pathParams: "signIn")
        let requestBody = try BodyRequest(url: url, body: request)
        let response = try await restClient.post(request: requestBody)

        let payload = response.payload
        switch response.statusCode {
        case 200:
            return try json.decode(payload, as: AuthenticatedUser.self)
        case 404:
            throw NotFoundError(message: "user does not exist")
        default:
            throw InternalError(message: exceptionMessage(payload: payload))
        }
    }
    
    private func exceptionMessage(payload : String) -> String {
        return "Failure, reason: \(payload)"
    }
}
