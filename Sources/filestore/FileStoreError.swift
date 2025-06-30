//
//  FileStoreError.swift
//  user-manager
//
//  Created by Yuvraj Singh on 25/06/25.
//


import Foundation

enum FileStoreError: Error {
    case fileNotFound(String)
    case fileExists(String)
    case ioError(String, Error)
}
