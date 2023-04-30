//
//  DashboardView.swift
//  Sicherheitsberater
//
//  Created by Benjamin Grunow on 11.04.23.
//

import SwiftUI

struct DashboardView: View {

    @EnvironmentObject var dataController: DataController
    @State var searchText = ""
    private var searchedEntities: [RequirementEntity] {
        if searchText.isEmpty {
            return dataController.savedEntities
        } else {
            return dataController.savedEntities.filter { $0.name!.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        NavigationStack {
            List {
                if searchText.isEmpty {
                    ForEach(dataController.objectTypes, id: \.self) { objectType in
                        DisclosureGroup(objectType) {
                            ForEach(dataController.savedEntities) { requirement in
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
                } else {
                    ForEach(searchedEntities) { requirement in
                        NavigationLink {
                            DetailView()
                        }label: {
                            ModuleItemView(requirement: requirement)
                        }
                    }
                }
            }
            .searchable(text: $searchText, prompt: "Suche Anforderung")
            .navigationTitle("Übersicht")
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
            .environmentObject(DataController())
    }
}
