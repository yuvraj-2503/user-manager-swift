//
//  ExistError.swift
//  user-manager
//
//  Created by Yuvraj Singh on 27/06/25.
//

public struct ExistError : Error {
    let message : String
    
    public init(message : String = "") {
        self.message = message
    }
    
    public var errorDescription: String? {
        return message
    }
}
