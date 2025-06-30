//
//  SignUpClient.swift
//  user-manager
//
//  Created by Yuvraj Singh on 26/06/25.
//

import Foundation
import rest_client_api
import util

public class SignUpClient {
    private let baseUrl: String
    private let restClient: RestClientAsync = UrlSessionRestClientAsync()
    private let json : Json = DefaultJson()
    

    public init(baseUrl: String) {
        self.baseUrl = baseUrl
    }

    public func sendOTP(emailId: String) async throws -> String {
        let url = Url(baseUrl: baseUrl, pathParams: "otp", "email")
        let requestBody = try BodyRequest(url: url, body: EmailRequest(emailId: emailId))
        let response: HttpResponse = try await restClient.post(request: requestBody)
        if(response.statusCode == 200) {
            let sessionResponse : SessionResponse = try json.decode(response.payload, as: SessionResponse.self)
            return sessionResponse.sessionId
        } else if(response.statusCode == 409) {
            throw ExistError(message: "User already exists by \(emailId)")
        } else {
            throw InternalError(message: "Internal error")
        }
    }

    public func sendOTP(phoneNumber: PhoneNumber) async throws -> String {
        let url = Url(baseUrl: baseUrl, pathParams: "otp", "sms")
        let requestBody = try BodyRequest(url: url, body: phoneNumber)
        let response: HttpResponse = try await restClient.post(request: requestBody)
        if(response.statusCode == 200) {
            let sessionResponse : SessionResponse = try json.decode(response.payload, as: SessionResponse.self)
            return sessionResponse.sessionId
        } else if(response.statusCode == 409) {
            throw ExistError(message: "User already exists by \(phoneNumber.countryCode)\(phoneNumber.number)")
        } else {
            throw InternalError(message: "Internal error")
        }
    }
    
    public func signUp(signUpRequest: SignUpRequest) async throws -> AuthenticatedUser {
        let url = Url(baseUrl: baseUrl, pathParams: "signup")
        let requestBody = try BodyRequest(url: url, body: signUpRequest)
        let response: HttpResponse = try await restClient.post(request: requestBody)

        switch response.statusCode {
        case 200:
            return try json.decode(response.payload, as: AuthenticatedUser.self)

        case 409:
            throw ExistError(message: "User already exists")

        case 429:
            throw OTPError(otpStatus: .maxAttemptsReached)

        case 404:
            throw OTPError(otpStatus: .notFound)

        case 401:
            let errorPayload = try json.decode(response.payload, as: Result.self)
            if errorPayload.code == "otp-expired" {
                throw OTPError(otpStatus: .expired)
            } else {
                throw OTPError(otpStatus: .incorrect)
            }

        default:
            let result = try json.decode(response.payload, as: Result.self)
            throw InternalError(message: "Failed to signup, reason: \(result.message)")
        }
    }
}

