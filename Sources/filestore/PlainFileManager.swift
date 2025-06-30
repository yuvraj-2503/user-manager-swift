//
//  PlainFileManager.swift
//  user-manager
//
//  Created by Yuvraj Singh on 25/06/25.
//

import Foundation

public final class PlainFileManager {
    private let blockManager: BlockManager

    public init(blockManager: BlockManager) {
        self.blockManager = blockManager
    }

    @discardableResult
    public func create(resourceId: String) throws -> File {
        try blockManager.create(resourceId: resourceId)
        return PlainFile(blockManager: blockManager, resourceId: resourceId)
    }

    public func exists(resourceId: String) -> Bool {
        return blockManager.exists(resourceId: resourceId)
    }

    public func get(resourceId: String) throws -> File {
        guard exists(resourceId: resourceId) else {
            throw FileStoreError.fileNotFound("File not found: \(resourceId)")
        }
        return PlainFile(blockManager: blockManager, resourceId: resourceId)
    }

    public func delete(resourceId: String) throws {
        guard exists(resourceId: resourceId) else {
            throw FileStoreError.fileNotFound("File not found: \(resourceId)")
        }
        try blockManager.delete(resourceId: resourceId)
    }
}
