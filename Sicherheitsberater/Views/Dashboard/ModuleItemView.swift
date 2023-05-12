//
//  ModuleItemView.swift
//  Sicherheitsberater
//
//  Created by Benjamin Grunow on 21.04.23.
//

import SwiftUI

struct ModuleItemView: View {
    @EnvironmentObject var dataController: DataController
    var requirement: RequirementEntity
    
    var body: some View {
        HStack{
            Button {
                requirement.isFulfilled.toggle()
                dataController.updateChangingTime(entity: requirement)
                dataController.saveData()
            }label: {
                Image(systemName: requirement.isFulfilled ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(.blue)
            }
            .buttonStyle(.plain)
            Text(requirement.name ?? "")
            Spacer()
        }
    }
}

struct ModuleItemView_Previews: PreviewProvider {
    static var previews: some View {
        ModuleItemView(requirement: DataController().savedEntities[1])
            .environmentObject(DataController())
    }
}
