//
//  SicherheitsberaterApp.swift
//  Sicherheitsberater
//
//  Created by Benjamin Grunow on 08.04.23.
//

import SwiftUI

@main
struct SicherheitsberaterApp: App {
    
    @StateObject var profileViewModel: ProfileViewModel = ProfileViewModel()
    @StateObject var dataController = DataController()

    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(profileViewModel)
                .environmentObject(dataController)
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
