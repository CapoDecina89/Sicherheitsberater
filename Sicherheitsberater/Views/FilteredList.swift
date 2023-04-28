//
//  FilteredList.swift
//  Sicherheitsberater
//
//  Created by Benjamin Grunow on 28.04.23.
//

import SwiftUI

struct FilteredList: View {
    
    @EnvironmentObject var profileViewModel: ProfileViewModel
    @EnvironmentObject var dataController: DataController
    
    private var objectTypes: [String] {
        Array(dataController.savedEntities.map { $0.objectType ?? ""}).uniqued()
    }
    
    var body: some View {
        List {
            ForEach(objectTypes, id: \.self) { objectType in
                Text(objectType)
                
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
    }
}

struct FilteredList_Previews: PreviewProvider {
    static var previews: some View {
        FilteredList()
    }
}
