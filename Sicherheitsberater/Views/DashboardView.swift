//
//  DashboardView.swift
//  Sicherheitsberater
//
//  Created by Benjamin Grunow on 11.04.23.
//

import SwiftUI

struct DashboardView: View {
    @EnvironmentObject var requirementData: RequirementData
    @EnvironmentObject var profilViewModel: ProfileViewModel
    private var relevantRequirements: [RequirementItem] {
        requirementData.filterRelevantRequirements(profile: profilViewModel.businessProfile)
    }
    private var objectTypes: [String] {
        requirementData.getObjectTypes(requirement: relevantRequirements)
    }
    
    var body: some View {
        NavigationStack {
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
            .navigationTitle("Übersicht")
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
            .environmentObject(RequirementData())
    }
}

