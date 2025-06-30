//
//  UserDataFile.swift
//  user-manager
//
//  Created by Yuvraj Singh on 28/06/25.
//

import Foundation
import filestore

public class UserDataFile: DataFile {
    private let file: JsonFile<UserData>

    public init(file: File) {
        self.file = JsonFile(file: file)
    }

    public func write(_ data: UserData) throws {
        try file.write(data)
    }

    public func read() throws -> UserData {
        return try file.read()
    }
}
