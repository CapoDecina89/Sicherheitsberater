//
//  EmergencyView.swift
//  Sicherheitsberater
//
//  Created by Benjamin Grunow on 27.04.23.
//

import SwiftUI

struct EmergencyView: View {
    
    @EnvironmentObject var profileViewmodel: ProfileViewModel
    @EnvironmentObject var documentViewModel: DocumentViewModel
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    Label("Wer meldet?", systemImage: "person.wave.2")
                    Label("Welches System ist betroffen?", systemImage: "pc")
                    Label("Was haben Sie beobachtet?", systemImage: "binoculars")
                    Label("Wann ist das Ereignis eingetreten?",systemImage: "clock")
                    Label("Wo befindet sich das IT-System?",systemImage: "mappin.and.ellipse")
                } header: {
                    Text("Informationen sammeln")
                }
                
                Section {
                    VStack(alignment: .center, spacing: 5) {
                        Label {
                            VStack(alignment: .leading) {
                                Text(profileViewmodel.businessProfile.emergencyContact.name)
                                Text(profileViewmodel.businessProfile.emergencyContact.company)
                                    .font(.caption)
                            }
                        } icon: {
                            Image(systemName: "person.crop.circle")
                                .foregroundColor(.secondary)
                                .font(.largeTitle)
                        }
                        Button {
                            let phone = "tel://"
                            let phoneNumberformatted = phone + profileViewmodel.businessProfile.emergencyContact.mobileNr
                            guard let url = URL(string: phoneNumberformatted) else { return }
                            UIApplication.shared.open(url)
                        } label: {
                            HStack{
                                Image(systemName: "phone.arrow.up.right.fill")
                                Text("IT-Notfallkontakt informieren")
                            }
                        }
                        .buttonStyle(.borderedProminent)
                    }
                }
                
                Section {
                    Text("So gehen sie weiter vor:")
                        .font(.title2)
                        .bold()
                    Label("Arbeit am System einstellen", systemImage: "lock.laptopcomputer")
                    Label("Auffälliges dokumentieren", systemImage: "camera")
                    Label("Notfallplan umsetzen", systemImage: "list.bullet.clipboard")
                }
                Section{
                    if (documentViewModel.checkForOwnFile(type: "notfallplan")) {
                        NavigationLink {
                            PDFUIView(documents: "notfallplan")
                        } label: {
                            VStack {
                                Image(systemName: "cross.case")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                .frame(height: 40)
                                Text("Notfallplan")
                            }
                        }
                    } else {
                        NavigationLink {
                            PDFUIView(bundled: "notfallplanBeispiel")
                        } label: {
                            VStack {
                                Image(systemName: "cross.case")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .foregroundColor(.secondary)
                                .frame(height: 40)
                                Text("Notfallplan BSI")
                            }
                        }
                    }
                }
            }
            //.font(.title3)
            .navigationTitle("Notfallplan")
            Spacer()
        }
    }
}

struct EmergencyView_Previews: PreviewProvider {
    static var previews: some View {
        EmergencyView()
            .environmentObject(ProfileViewModel())
            .environmentObject(DocumentViewModel())
    }
}
