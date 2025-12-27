//
//  Result.swift
//  user-manager
//
//  Created by Yuvraj Singh on 27/06/25.
//

public struct Result: Codable {
    let code: String
    let message: String
    
    public init(code: String, message: String) {
        self.code = code
        self.message = message
    }
    
}

