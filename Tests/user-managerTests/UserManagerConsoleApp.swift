//
//  UserManagerConsoleApp.swift
//  user-manager
//
//  Created by Yuvraj Singh on 30/06/25.
//


import Foundation
import user_manager
import filestore

@main
@MainActor
struct UserManagerConsoleApp {
    
    static let locatorUrl = "http://56.228.27.35:8080/api/v1"
    static let path = FileManager.default.currentDirectoryPath
    
    static func getDevice() -> Device {
        return Device(serialNumber: UUID().uuidString, name: "MacBook", os: "macOS", fingerPrint: UUID().uuidString, deviceType: .desktop)
    }
    
    
    static func getUserManager() async throws -> UserManager {
        let authConfig = AuthConfig(app: .SOCIAL, device: getDevice(), locatorUrl: locatorUrl, env: .development)
        return try await UserManagerImpl(path: URL(filePath: path), authConfig: authConfig)
    }
    
    
    static func main() async throws {
        var userManager: UserManager
        do {
            userManager = try await getUserManager()
        } catch{
            throw InternalError(message: "UserManager Init Failed")
        }

        await runMenuLoop(with: userManager)
    }
    
    static func runMenuLoop(with userManager: UserManager) async {
        while true {
            print("""
            1. Sign Up with Email
            2. Sign Up with Phone
            3. Sign In with Email
            4. Sign In with Phone
            5. Offline Sign In
            6. Get URLs
            Choose an option:
            """)

            guard let choice = readLine(), let option = Int(choice) else {
                print("Invalid input"); continue
            }

            switch option {
            case 1: await signUpWithEmail(userManager)
            case 2: await signUpWithPhone(userManager)
            case 3: await signInWithEmail(userManager)
            case 4: await signInWithPhone(userManager)
            case 5: offlineSignIn(userManager)
            case 6: getUrls(userManager)
            default: print("Invalid option")
            }
        }
    }

    static func signUpWithEmail(_ manager: UserManager) async {
        print("Enter email:", terminator: " "); guard let email = readLine() else { return }
        let session = manager.createSignUpSession(contact: .email(email))
        try? await session.sendOTP()
        print("OTP sent. Enter OTP:", terminator: " "); guard let otp = readLine(), let code = Int(otp) else { return }
        let user = try? await session.signUp(otp: code)
        print("Signed up: \(user?.userId ?? "Unknown")")
    }

    static func signUpWithPhone(_ manager: UserManager) async {
        print("Enter country code and number:", terminator: " "); guard let code = readLine(), let number = readLine() else { return }
        let phone = PhoneNumber(countryCode: code, number: number)
        let session = manager.createSignUpSession(contact: .phone(phone))
        try? await session.sendOTP()
        print("OTP sent. Enter OTP:", terminator: " "); guard let otp = readLine(), let codeInt = Int(otp) else { return }
        let user = try? await session.signUp(otp: codeInt)
        print("Signed up: \(user?.userId ?? "Unknown")")
    }

    static func signInWithEmail(_ manager: UserManager) async {
        print("Enter email:", terminator: " "); guard let email = readLine() else { return }
        let session = manager.createSignInSession(contact: .email(email))
        try? await session.sendOTP()
        print("OTP sent. Enter OTP:", terminator: " "); guard let otp = readLine(), let code = Int(otp) else { return }
        try? await session.verifyOTP(otp: code)
        if let userId = session.getVerifyResponse()?.getUserId() {
            let user = try? await manager.signIn(userId: userId)
            print("Signed in: \(user?.userId ?? "Unknown")")
        }
    }

    static func signInWithPhone(_ manager: UserManager) async {
        print("Enter country code and number:", terminator: " "); guard let code = readLine(), let number = readLine() else { return }
        let phone = PhoneNumber(countryCode: code, number: number)
        let session = manager.createSignInSession(contact: .phone(phone))
        try? await session.sendOTP()
        print("OTP sent. Enter OTP:", terminator: " "); guard let otp = readLine(), let codeInt = Int(otp) else { return }
        try? await session.verifyOTP(otp: codeInt)
        if let userId = session.getVerifyResponse()?.getUserId() {
            let user = try? await manager.signIn(userId: userId)
            print("Signed in: \(user?.userId ?? "Unknown")")
        }
    }

    static func offlineSignIn(_ manager: UserManager) {
        print("Enter user ID:", terminator: " "); guard let userId = readLine() else { return }
        do {
            let user = try manager.offlineSignIn(userId: userId)
            print("Offline signed in: \(user.userId)")
        } catch {
            print("User not found locally.")
        }
    }

    static func getUrls(_ manager: UserManager) {
        let urls = manager.getUrls()
        print("URLs: \(urls)")
    }
}
