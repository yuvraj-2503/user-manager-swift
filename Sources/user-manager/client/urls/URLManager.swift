//
//  URLManager.swift
//  user-manager
//
//  Created by Yuvraj Singh on 30/06/25.
//

import Foundation
import filestore
import util

public final class URLManager {
    private static let fileName = "urls"
    
    private let blockManager: BlockManager
    private let locatorUrl: String
    private let env: Env
    private let json: Json = DefaultJson()

    public init(locatorUrl: String, path: URL, env: Env) {
        self.locatorUrl = locatorUrl
        self.env = env
        self.blockManager = BlockManager(blockDirectory: path)
    }

    public func getUrl() async throws -> [String: String] {
        if blockManager.exists(resourceId: Self.fileName) {
            do {
                return try getFile().read()
            } catch {
                try blockManager.delete(resourceId: Self.fileName)
                return try await create()
            }
        } else {
            return try await create()
        }
    }

    public func sync() async -> [String: String] {
        let urls = await ServiceLocatorClient(locatorUrl: locatorUrl, env: env).get()
        let file = getFile()
        try? file.write(urls)
        return urls
    }

    private func create() async throws -> [String: String] {
        let urls = await ServiceLocatorClient(locatorUrl: locatorUrl, env: env).get()
        try blockManager.create(resourceId: Self.fileName)
        let file = getFile()
        try file.write(urls)
        return urls
    }

    private func getFile() -> JsonFile<[String: String]> {
        let plainFile = PlainFile(blockManager: blockManager, resourceId: Self.fileName)
        return JsonFile<[String: String]>(file: plainFile)
    }
}
