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
    var name: String
    var explanation: String
    var isFulfilled: Bool? 
    var changingDate: Date?
    //var isRelevant: Bool? = true
}
