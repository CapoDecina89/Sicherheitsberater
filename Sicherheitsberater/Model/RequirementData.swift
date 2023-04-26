//
//  RequirementData.swift
//  Sicherheitsberater
//
//  Created by Benjamin Grunow on 24.04.23.
//

import Foundation

class RequirementData: ObservableObject {
    //Array mit allen Daten der Requirements
    @Published var requirements: [RequirementItem] = Bundle.main.decode([RequirementItem].self, from: "requirements.json")
   
    func getObjectTypes(requirement:[RequirementItem]) -> [String] {
        return Array(requirement.map {$0.objectType}).uniqued()
    }
    
    //Change RequirementItem.isRelevant depending on selected Profile Options
    func filterRelevantRequirements(profile: Profile) -> [RequirementItem] {
        var relevantRequirements: [RequirementItem] = requirements.filter {($0.id.hasPrefix("A1") || $0.id.hasPrefix("A5")) && !$0.objectType.contains("Mobiltelefon") && !$0.objectType.contains("Tablet") }
        
        switch profile.size {
        case .medium:
            relevantRequirements.append(contentsOf: requirements.filter { $0.id.hasPrefix("A2") })
        case .large:
            relevantRequirements.append(contentsOf: requirements.filter { $0.id.hasPrefix("A2") || $0.id.hasPrefix("A3") })
        default:
            break
        }
        
        if (profile.hasBigMedTech == true) {
            relevantRequirements.append(contentsOf: requirements.filter { $0.id.hasPrefix("A4") })
        } else {}
        
        if (profile.hasMobile == true) {
            relevantRequirements.append(contentsOf: requirements.filter { $0.objectType.contains("Mobiltelefon") })
        } else {}
        
        if (profile.hasTablet == true) {
            relevantRequirements.append(contentsOf: requirements.filter { $0.objectType.contains("Tablet") })
        } else {}
        
        if (profile.hasParallelMode == true) {
            //relevantRequirements.append(contentsOf: requirements.filter { $0.objectType.contains("Mobiltelefon") })
        } else {}
        
        if (profile.hasWebServices == true) {
            //relevantRequirements.append(contentsOf: requirements.filter { $0.objectType.contains("Mobiltelefon") })
        } else {}
        
        return relevantRequirements.sorted { $0.id < $1.id
        }
    }
}
