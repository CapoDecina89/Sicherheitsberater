//
//  DashboardView.swift
//  Sicherheitsberater
//
//  Created by Benjamin Grunow on 11.04.23.
//

import SwiftUI

struct DashboardView: View {

    @EnvironmentObject var dataController: DataController
    
    var body: some View {
        NavigationStack {
            List {
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
                /*ForEach(objectTypes) { objectType in
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
                }*/
            }
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
