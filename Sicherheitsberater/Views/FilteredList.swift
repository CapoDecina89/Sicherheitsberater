//
//  FilteredList.swift
//  Sicherheitsberater
//
//  Created by Benjamin Grunow on 28.04.23.
//

import SwiftUI

struct FilteredList: View {
    
    @EnvironmentObject var requirementData: RequirementData
    @EnvironmentObject var profileViewModel: ProfileViewModel
    
    private var relevantRequirements: [RequirementItem] {
        requirementData.filterRelevantRequirements(profile: profileViewModel.businessProfile)
    }
    private var objectTypes: [String] {
        requirementData.getObjectTypes(requirement: relevantRequirements)
    }
    
    var body: some View {
        List {
            ForEach(objectTypes, id: \.self) { objectType in
                DisclosureGroup(objectType) {
                    ForEach(relevantRequirements) { requirement in
                        if (requirement.objectType == objectType) {
                            NavigationLink {
                                DetailView()
                            }label: {
                                ModuleItemView(requirement: requirement)
                            }
                        }else {}
                    }
                }
            }
        }
    }
}

struct FilteredList_Previews: PreviewProvider {
    static var previews: some View {
        FilteredList()
    }
}
