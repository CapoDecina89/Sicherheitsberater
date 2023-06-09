//
//  ContentView.swift
//  Sicherheitsberater
//
//  Created by Benjamin Grunow on 08.04.23.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var dataController: DataController
    @EnvironmentObject var profileViewModel: ProfileViewModel
    @EnvironmentObject var documentViewModel: DocumentViewModel
    
    
    
    var body: some View {
        TabView {
            DashboardView()
                .tabItem {
                    Label("Übersicht", systemImage: "house")
                }
                .onAppear {
                    dataController.fetchRequirements(forProfile: profileViewModel.businessProfile)
                    dataController.getObjectTypes()
                }
            DocumentView()
                .tabItem {
                    Label("Doku", systemImage: "doc.fill")
                }
                .onAppear {
                    documentViewModel.updateStatus()
                }
            EmergencyView()
                .tabItem {
                    Label("Notfall", systemImage: "cross.circle.fill")
                }
            ProfileView()
                .tabItem {
                    Label("Profil", systemImage: "person.circle")
                }
        }
        .environmentObject(dataController)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(DataController())
            .environmentObject(ProfileViewModel())
            .environmentObject(DocumentViewModel())
    }
}
