//
//  Device.swift
//  user-manager
//
//  Created by Yuvraj Singh on 26/06/25.
//

public struct Device: Codable, Sendable {
    let serialNumber: String
    let name: String
    let os: String
    let fingerPrint: String
    let deviceType: DeviceType
    
    public init(serialNumber: String, name: String, os: String, fingerPrint: String, deviceType: DeviceType) {
        self.serialNumber = serialNumber
        self.name = name
        self.os = os
        self.fingerPrint = fingerPrint
        self.deviceType = deviceType
    }
}

public enum DeviceType: String, Codable, Sendable {
    case android = "ANDROID"
    case ios = "IOS"
    case desktop = "DESKTOP"
}
