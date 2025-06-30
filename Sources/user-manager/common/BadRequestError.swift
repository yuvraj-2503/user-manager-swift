//
//  BadRequestError.swift
//  user-manager
//
//  Created by Yuvraj Singh on 27/06/25.
//

public struct BadRequestError : Error {
    let message: String
    public init(message : String = "Bad request") {
        self.message = message
    }
    
    public var errorDescription: String? {
        return message
    }
}
