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
        //ggf. erst nach Geräten, dann nach profile.size filtern
        var relevantRequirements: [RequirementItem] = requirements.filter { !$0.objectType.contains("Mobil") && !$0.objectType.contains("Tablet") && !$0.objectType.contains("MDM") && !$0.id.hasPrefix("A4") }
        
        
        if (profile.hasBigMedTech == true) {
            relevantRequirements.append(contentsOf: requirements.filter { $0.id.hasPrefix("A4") })
        } else {}
        
        if (profile.hasMobileDevice == true) {
            relevantRequirements.append(contentsOf: requirements.filter { $0.objectType.contains("Mobil") || $0.objectType.contains("Tablet") || $0.objectType.contains("MDM")})
        } else {}
        
        if (profile.hasWebServices == true) {
            //relevantRequirements.append(contentsOf: requirements.filter { $0.objectType.contains("Mobiltelefon") })
        } else {}
        
        switch profile.size {
        case.small:
            relevantRequirements = relevantRequirements.filter {
                !$0.id.hasPrefix("A2") || !$0.id.hasPrefix("A3")
            }
        case .medium:
            relevantRequirements = relevantRequirements.filter {
                !$0.id.hasPrefix("A3")
            }
        default:
            break
        }
        return relevantRequirements.sorted { $0.id < $1.id
        }
    }
}
