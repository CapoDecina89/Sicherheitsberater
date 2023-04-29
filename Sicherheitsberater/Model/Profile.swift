//
//  Profile.swift
//  Sicherheitsberater
//
//  Created by Benjamin Grunow on 25.04.23.
//

import Foundation

struct Profile: Codable {
    var emergencyContact: EmergencyContact = EmergencyContact()
    var size: SizeCategory = .small
    var hasBigMedTech: Bool = false
    var hasMobileDevice: Bool = false
    var hasWebServices: Bool = false
}

enum SizeCategory: String, Codable {
case small, medium, large
}

struct EmergencyContact: Codable {
    var name: String = ""
    var mobileNr: String = ""
}
