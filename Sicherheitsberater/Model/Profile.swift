//
//  Profile.swift
//  Sicherheitsberater
//
//  Created by Benjamin Grunow on 25.04.23.
//

import Foundation

struct Profile: Codable {
    var name: String = ""
    var size: SizeCategory = .small
    var hasBigMedTech: Bool = false
    var hasMobile: Bool = false
    var hasTablet: Bool = false
    var hasParallelMode = false
    var hasWebServices: Bool = false
}

enum SizeCategory: Codable {
case small, medium, large
}
