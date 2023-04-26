//
//  ContentView.swift
//  Sicherheitsberater
//
//  Created by Benjamin Grunow on 08.04.23.
//

import SwiftUI

struct ContentView: View {
    
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
            ProfileView()
                .tabItem {
                    Label("Profil", systemImage: "person.circle")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(RequirementData())
            .environmentObject(ProfileViewModel())
    }
}
