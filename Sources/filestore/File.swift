//
//  File.swift
//  user-manager
//
//  Created by Yuvraj Singh on 25/06/25.
//


import Foundation

public protocol File {
    func read() throws -> InputStream
    func write() throws -> OutputStream
}
