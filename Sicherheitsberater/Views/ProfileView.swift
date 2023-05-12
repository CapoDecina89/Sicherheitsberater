//
//  ProfileView.swift
//  Sicherheitsberater
//
//  Created by Benjamin Grunow on 21.04.23.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var profileViewModel: ProfileViewModel
    @State private var showingWebserviceInfo = false
    @Environment(\.dismiss) var dismiss
    
    
    var body: some View {
        NavigationView{
            VStack {
                Form {
                    Section{
                        TextField("Firma (optional)", text: $profileViewModel.businessProfile.emergencyContact.company)
                        TextField("IT-Verantwortlicher/-Dienstleister", text: $profileViewModel.businessProfile.emergencyContact.name)
                        TextField("Notfallnummer", text: $profileViewModel.businessProfile.emergencyContact.mobileNr)
                    }header: {
                        Text("IT-Notfallkontakt")
                    }
                    
                    Section{
                        Picker(selection: $profileViewModel.businessProfile.size, label: Text("Size")) {
                            Text("< 6").tag(SizeCategory.small)
                            Text("6 - 20").tag(SizeCategory.medium)
                            Text("> 20").tag(SizeCategory.large)
                        }
                        .pickerStyle(.segmented)
                    }header: {
                        Text("Mitarbeiter mit Datenzugriff")
                    }footer: {
                        Text("Die Anzahl der Mitarbeiter mit Datenzugriff bestimmt ob ihre Praxis die Anforderungen für kleine, mittlere oder große Praxen erfüllen muss.")
                    }
                    
                    
                    deviceSettings
                }
            }
            .navigationTitle("Profil")
        }
        .sheet(isPresented: $showingWebserviceInfo){
            HStack{
                Text("Webanwendungen vorhanden")
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
                Button {
                    showingWebserviceInfo = false
                }label:{
                    Image(systemName: "x.circle.fill")
                        .foregroundColor(.secondary)
                }
            }
            .padding(.horizontal)
            
            Text("Die Richtlinie meint damit Dienste, die für die Patienten oder andere Externe, über das Internet angeboten werden. Darunter fallen z.B. Online-Terminvergabe oder Online-Anamnese.")
                .presentationDetents([.fraction(0.30)])
                .padding()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(ProfileViewModel())
    }
}
private extension ProfileView {
        
    var deviceSettings: some View {
        Section {
            Toggle("Medizinische Großgeräte vorhanden (MTR, CT, ...)", isOn: $profileViewModel.businessProfile.hasBigMedTech)
            // Mobiltelefone, Smartphone und Tablet zusammenfassen, da Trennung nicht zeitgemäß
            Toggle("Mobilgeräte (Smartphone/Tablet) vorhanden", isOn: $profileViewModel.businessProfile.hasMobileDevice)
            Toggle(isOn: $profileViewModel.businessProfile.hasWebServices) {
                HStack{
                    Text("Webservices vorhanden")
                    Spacer()
                    Button {
                        showingWebserviceInfo.toggle()
                    }label:{
                        Image(systemName: "info.circle")
                    }
                }
            }
        } header: {
            Text("vorhandene Geräte")
        }footer: {
            Text("Durch Ihre Auswahl werden Ihnen Maßnahmen nur angezeigt, wenn Sie die entsprechenden Geräte oder Dienste auch verwenden.")
        }
    }
}
