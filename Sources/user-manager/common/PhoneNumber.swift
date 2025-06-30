//
//  PhoneNumber.swift
//  user-manager
//
//  Created by Yuvraj Singh on 26/06/25.
//

public struct PhoneNumber: Codable, Sendable {
    let countryCode: String
    let number: String
    
    public init(countryCode: String, number: String) {
        self.countryCode = countryCode
        self.number = number
    }
    
}
