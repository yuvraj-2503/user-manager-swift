//
//  Contact.swift
//  user-manager
//
//  Created by Yuvraj Singh on 27/06/25.
//

import Foundation

public struct Contact: Codable {
    let emailId: String?
    let phoneNumber: PhoneNumber?

    private init(emailId: String?, phoneNumber: PhoneNumber?) {
        self.emailId = emailId
        self.phoneNumber = phoneNumber
    }

    public static func email(_ email: String) -> Contact {
        return Contact(emailId: email, phoneNumber: nil)
    }

    public static func phone(_ phoneNumber: PhoneNumber) -> Contact {
        return Contact(emailId: nil, phoneNumber: phoneNumber)
    }
}
