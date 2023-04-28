//
//  ModuleItemView.swift
//  Sicherheitsberater
//
//  Created by Benjamin Grunow on 21.04.23.
//

import SwiftUI

struct ModuleItemView: View {
    @EnvironmentObject var dataController: DataController
    @State private var showingInfo = false
    var requirement: RequirementEntity
    
    var body: some View {
        HStack{
            Button {
                requirement.isFulfilled.toggle()
                dataController.saveData()
            }label: {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.blue)
            }
            Text(requirement.name ?? "")
            Spacer()
            Button {
                showingInfo.toggle()
            }label: {
                Image(systemName: "info.circle")
            }
            .buttonStyle(.plain)
            .sheet(isPresented: $showingInfo) {
                HStack{
                    Text(requirement.name ?? "")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding()
                    Spacer()
                    Button {
                        showingInfo = false
                    }label:{
                        Image(systemName: "x.circle.fill")
                            .foregroundColor(.secondary)
                    }
                    .padding()
                }
                Text(requirement.explanation ?? "")
                    .padding()
                Spacer()
                .presentationDetents([.medium])
            }
        }
    }
}

struct ModuleItemView_Previews: PreviewProvider {
    static var previews: some View {
        ModuleItemView(requirement: DataController().savedEntities[1])
            .environmentObject(DataController())
    }
}
