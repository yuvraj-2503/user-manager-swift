//
//  InternalError.swift
//  user-manager
//
//  Created by Yuvraj Singh on 28/06/25.
//

public struct InternalError : Error {
    let message : String
    
    public init(message: String = "Internal error") {
        self.message = message
    }
    
    public var errorDescription: String? {
        return message
    }
}
