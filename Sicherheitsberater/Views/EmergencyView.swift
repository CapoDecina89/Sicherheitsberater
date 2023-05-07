//
//  EmergencyView.swift
//  Sicherheitsberater
//
//  Created by Benjamin Grunow on 27.04.23.
//

import SwiftUI

struct EmergencyView: View {
    
    @EnvironmentObject var profileViewmodel: ProfileViewModel
    
    var body: some View {
        NavigationStack {
            Text("Ruhe bewahren & Vorfall melden!")
                .font(.title2)
            GroupBox {
                VStack (alignment: .leading, spacing: 10) {
                    Label("Wer meldet?", systemImage: "person.wave.2")
                    Label("Welches System ist betroffen?", systemImage: "pc")
                    Label("Was haben Sie beobachtet?", systemImage: "binoculars")
                    Label("Wann ist das Ereignis eingetreten?",systemImage: "clock")
                    Label("Wo befndet sich das IT-System?",systemImage: "mappin.and.ellipse")
                }
            }
            .font(.title3)
            .padding()
            
            GroupBox {
                VStack(alignment: .leading) {
                    Label {
                        VStack(alignment: .leading) {
                            Text(profileViewmodel.businessProfile.emergencyContact.name)
                            Text(profileViewmodel.businessProfile.emergencyContact.company)
                                .font(.caption)
                        }
                    } icon: {
                        Circle()
                            .fill(.secondary)
                            .frame(width: 44, height: 44, alignment: .center)
                            .overlay(Image(systemName: "person"))
                    }
                    Button {
                        
                    } label: {
                        HStack{
                            Image(systemName: "phone.arrow.up.right.fill")
                            Text("IT-Notfallkontakt informieren")
                        }
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
            Text("So gehen sie weiter vor:")
                .font(.title)
            GroupBox {
                Text("Auffälliges dokumentieren")
                
                
    
            }
            .font(.title2)
            .navigationTitle("Notfallplan")
            Spacer()
        }
    }
}

struct EmergencyView_Previews: PreviewProvider {
    static var previews: some View {
        EmergencyView()
            .environmentObject(ProfileViewModel())
    }
}
