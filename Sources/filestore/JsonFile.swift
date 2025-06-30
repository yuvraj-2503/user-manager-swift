//
//  JsonFile.swift
//  user-manager
//
//  Created by Yuvraj Singh on 25/06/25.
//

import Foundation
import util  // assuming DefaultJson lives here

public final class JsonFile<T: Codable>: DataFile {
    public typealias DataType = T

    private let file: File
    private let json: DefaultJson

    public init(file: File, json: DefaultJson = DefaultJson()) {
        self.file = file
        self.json = json
    }

    public func write(_ data: T) throws {
        let encoded = try json.encode(data)
        guard let bytes = encoded.data(using: .utf8) else {
            throw FileStoreError.ioError("Failed to encode data", NSError())
        }

        let stream = try file.write()
        stream.open()
        let written = bytes.withUnsafeBytes {
            stream.write($0.bindMemory(to: UInt8.self).baseAddress!, maxLength: bytes.count)
        }
        stream.close()

        if written <= 0 {
            throw FileStoreError.ioError("Failed to write data to file", NSError())
        }
    }

    public func read() throws -> T {
        let stream = try file.read()
        stream.open()

        var buffer = [UInt8](repeating: 0, count: 4096)
        var data = Data()

        while stream.hasBytesAvailable {
            let bytesRead = stream.read(&buffer, maxLength: buffer.count)
            if bytesRead > 0 {
                data.append(buffer, count: bytesRead)
            } else {
                break
            }
        }

        stream.close()

        guard let jsonString = String(data: data, encoding: .utf8) else {
            throw FileStoreError.ioError("Failed to read data from file", NSError())
        }

        return try json.decode(jsonString, as: T.self)
    }
}
