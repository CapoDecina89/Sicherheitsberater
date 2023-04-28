//
//  ContentView.swift
//  Sicherheitsberater
//
//  Created by Benjamin Grunow on 08.04.23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var requirementData = RequirementData()
    @StateObject var profilViewModel = ProfileViewModel()
    
    var body: some View {
        TabView {
            DashboardView()
                .tabItem {
                    Label("Übersicht", systemImage: "house")
                }
            DocumentationView()
                .tabItem {
                    Label("Doku", systemImage: "doc.fill")
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
        .environmentObject(requirementData)
        .environmentObject(profilViewModel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
