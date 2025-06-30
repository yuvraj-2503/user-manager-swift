//
//  PlainFile.swift
//  user-manager
//
//  Created by Yuvraj Singh on 25/06/25.
//

import Foundation

public final class PlainFile: File {
    private let blockManager: BlockManager
    private let resourceId: String

    public init(blockManager: BlockManager, resourceId: String) {
        self.blockManager = blockManager
        self.resourceId = resourceId
    }

    public func read() throws -> InputStream {
        return try blockManager.read(resourceId: resourceId)
    }

    public func write() throws -> OutputStream {
        return try blockManager.write(resourceId: resourceId)
    }
}
