//
//  FileNameGenerator.swift
//  user-manager
//
//  Created by Yuvraj Singh on 28/06/25.
//


import Foundation

public class FileNameGenerator {
    public func user(_ userId: String) -> String {
        return generate(userId, suffix: "u")
    }

    public func profile(_ userId: String) -> String {
        return generate(userId, suffix: "p")
    }

    public func profilePicture(_ userId: String) -> String {
        return generate(userId, suffix: "pp")
    }

    private func generate(_ userId: String, suffix: String) -> String {
        return "\(userId)_\(suffix)"
    }
}
