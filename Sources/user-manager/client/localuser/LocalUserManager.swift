//
//  LocalUserManager.swift
//  user-manager
//
//  Created by Yuvraj Singh on 28/06/25.
//

import filestore
import Foundation

public class LocalUserManager {
    private let plainFileManager: PlainFileManager
    private let fileNameGenerator = FileNameGenerator()

    public init(path: URL) {
        let blockManager = BlockManager(blockDirectory: path)
        self.plainFileManager = PlainFileManager(blockManager: blockManager)
    }

    public func create(userData: UserData) throws {
        let file = try plainFileManager.create(resourceId: fileNameGenerator.user(userData.userId))
        let userDataFile = UserDataFile(file: file)
        try userDataFile.write(userData)
    }

    public func update(userData: UserData) throws {
        let file = try plainFileManager.get(resourceId: fileNameGenerator.user(userData.userId))
        let userDataFile = UserDataFile(file: file)
        try userDataFile.write(userData)
    }

    public func delete(userId: String) throws {
        try plainFileManager.delete(resourceId: fileNameGenerator.user(userId))
    }

    public func exists(userId: String) -> Bool {
        return plainFileManager.exists(resourceId: fileNameGenerator.user(userId))
    }

    public func get(userId: String) throws -> UserData {
        let file = try plainFileManager.get(resourceId: fileNameGenerator.user(userId))
        let userDataFile = UserDataFile(file: file)
        return try userDataFile.read()
    }
}
