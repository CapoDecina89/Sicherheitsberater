//
//  ProfileView.swift
//  Sicherheitsberater
//
//  Created by Benjamin Grunow on 21.04.23.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var profileViewModel: ProfileViewModel
    @State private var showingKonnektorInfo = false
    @State private var showingWebserviceInfo = false
    @Environment(\.dismiss) var dismiss
    
    
    var body: some View {
        NavigationView{
            VStack {
                Form {
                    Section{
                        TextField("Name der Praxis", text: $profileViewModel.businessProfile.name)
                    }header: {
                        Text("Praxisdaten")
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
        //Sheets sollten in eigene View ausgegliedert werden
        
        .sheet(isPresented: $showingKonnektorInfo){
            HStack{
                Text("Konnektor im Parallelbetrieb")
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
                Button {
                    showingKonnektorInfo = false
                }label:{
                    Image(systemName: "x.circle.fill")
                        .foregroundColor(.secondary)
                }
            }
            .padding(.horizontal)
            
            Text("Die Betriebsart des Konnektors kann in der Managementoberfläche des Konnektors eingesehen werden. Konsultieren sie im Zweifel die Bedienungsanleitung.\n\nWenn nicht alle Verbindungen in das Internet über den Konnektor laufen, sondern einzelne Geräte oder Netzwerkteile direkt mit dem Router verbunden sind, dann liegt ein Parallelbetrieb vor und für diese Verbindungen sind nicht über den Konnektor abgesichert.\n\nEs wird im Zweifel empfohlen die Option Reihenbetrieb zu wählen.")
                .presentationDetents([.medium])
                .padding()
        }
        
        .sheet(isPresented: $showingWebserviceInfo){
            HStack{
                Text("Webservice vorhanden")
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
            
            Text("Test")
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
        Section{
            
            Toggle("Medizinische Großgeräte vorhanden (MTR, CT, ...)", isOn: $profileViewModel.businessProfile.hasBigMedTech)
            Toggle("Mobiltelefone vorhanden", isOn: $profileViewModel.businessProfile.hasMobile)
            Toggle("Tablets vorhanden", isOn: $profileViewModel.businessProfile.hasTablet)
            Toggle(isOn: $profileViewModel.businessProfile.hasParallelMode) {
                HStack{
                    Text("Konnektor im Parallelbetrieb")
                    Spacer()
                    Button {
                        showingKonnektorInfo.toggle()
                    }label:{
                        Image(systemName: "info.circle")
                        }
                }
                
                
            }
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
            Text("Durch Ihre Auswahl werden Ihnen Anforderungen nur angezeigt, wenn Sie die entsprechenden Geräte auch verwenden.")
        }
    }
}
