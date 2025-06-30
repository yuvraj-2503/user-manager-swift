//
//  BlockManager.swift
//  user-manager
//
//  Created by Yuvraj Singh on 25/06/25.
//

import Foundation

public class BlockManager {
    private let blockDirectory: URL
    private let fileManager = FileManager.default

    public init(blockDirectory: URL) {
        self.blockDirectory = blockDirectory
    }

    public func read(resourceId: String) throws -> InputStream {
        let filePath = try getFilePath(resourceId: resourceId)
        guard let inputStream = InputStream(url: filePath) else {
            throw FileStoreError.ioError("Could not read block for resource \(resourceId)", NSError())
        }
        return inputStream
    }

    public func write(resourceId: String) throws -> OutputStream {
        let filePath = try getFilePath(resourceId: resourceId)
        guard let outputStream = OutputStream(url: filePath, append: false) else {
            throw FileStoreError.ioError("Could not write block for resource \(resourceId)", NSError())
        }
        return outputStream
    }

    public func create(resourceId: String) throws {
        let filePath = blockDirectory.appendingPathComponent(resourceId)
        if fileManager.fileExists(atPath: filePath.path) {
            throw FileStoreError.fileExists("Resource block already exists for \(resourceId)")
        }
        let created = fileManager.createFile(atPath: filePath.path, contents: nil, attributes: nil)
        if !created {
            throw FileStoreError.ioError("Failed to create block for resource \(resourceId)", NSError())
        }
    }

    public func delete(resourceId: String) throws -> Bool {
        let filePath = blockDirectory.appendingPathComponent(resourceId)
        if !fileManager.fileExists(atPath: filePath.path) {
            return false
        }
        do {
            try fileManager.removeItem(at: filePath)
            return true
        } catch {
            throw FileStoreError.ioError("Failed to delete block for resource \(resourceId)", error)
        }
    }

    public func exists(resourceId: String) -> Bool {
        let filePath = blockDirectory.appendingPathComponent(resourceId)
        return fileManager.fileExists(atPath: filePath.path)
    }

    private func getFilePath(resourceId: String) throws -> URL {
        let filePath = blockDirectory.appendingPathComponent(resourceId)
        if !fileManager.fileExists(atPath: filePath.path) {
            throw FileStoreError.fileNotFound("Block file not found for resource \(resourceId)")
        }
        return filePath
    }
}
