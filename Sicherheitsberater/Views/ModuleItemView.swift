//
//  ModuleItemView.swift
//  Sicherheitsberater
//
//  Created by Benjamin Grunow on 21.04.23.
//

import SwiftUI

struct ModuleItemView: View {
    @State private var showingInfo = false
    var requirement: RequirementItem
    
    var body: some View {
        HStack{
            Image(systemName: /*requirement.isCompleted ? */ "checkmark.circle.fill"/*: "circle"*/)
                .foregroundColor(.blue)
            Text(requirement.requirement)
            Spacer()
            Button {
                showingInfo.toggle()
            }label: {
                Image(systemName: "info.circle")
            }
            .buttonStyle(.plain)
            .sheet(isPresented: $showingInfo) {
                HStack{
                    Text(requirement.requirement)
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
                Text(requirement.explanation)
                    .padding()
                Spacer()
                .presentationDetents([.medium])
            }
        }
    }
}

struct ModuleItemView_Previews: PreviewProvider {
    static var requirements: [RequirementItem] = Bundle.main.decode([RequirementItem].self, from: "requirements.json")
    static var previews: some View {
        ModuleItemView(requirement: requirements[1])
    }
}
