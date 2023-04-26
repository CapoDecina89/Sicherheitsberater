//
//  RequirementItem.swift
//  Sicherheitsberater
//
//  Created by Benjamin Grunow on 25.04.23.
//

import Foundation

struct RequirementItem: Codable, Hashable, Identifiable {
    var id: String
    var objectType: String
    var requirement: String
    var description: String
    var isFulfilled: Bool? = false
    var changingDate: Date?
    //var isRelevant: Bool? = true
}
