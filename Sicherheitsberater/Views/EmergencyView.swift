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
                .font(.title)
            GroupBox {
                Text("Meldung absetzen")
                    .font(.title2)
                Button {
                    
                } label: {
                    HStack{
                        Image(systemName: "phone.arrow.up.right.fill")
                        Text("IT-Notfallkontakt informieren")
                    }
                }
                .buttonStyle(.borderedProminent)
                
                GroupBox{
                    Text("Wer meldet?")
                    Text("Welches System ist betroffen?")
                    Text("Was haben Sie beobachtet?")
                    Text("Wann ist das Ereignis eingetreten?")
                    Text("Wo befndet sich das betrofene IT-System?")
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
