//
//  OTPError.swift
//  user-manager
//
//  Created by Yuvraj Singh on 28/06/25.
//

public struct OTPError : Error {
    private let otpStatus: OTPStatus
    
    public var message : String {
        return otpStatus.rawValue
    }
    
    public init(otpStatus : OTPStatus) {
        self.otpStatus = otpStatus;
    }
    
    public var errorDescription: String? {
        return message
    }
}
