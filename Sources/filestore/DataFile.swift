//
//  DataFile.swift
//  user-manager
//
//  Created by Yuvraj Singh on 25/06/25.
//

public protocol DataFile {
    associatedtype DataType

    func write(_ data: DataType) throws
    func read() throws -> DataType
}
