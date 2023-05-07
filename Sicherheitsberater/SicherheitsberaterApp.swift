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
    @StateObject var documentViewModel: DocumentViewModel = DocumentViewModel()
    @Environment(\.scenePhase) var scenePhase

    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(profileViewModel)
                .environmentObject(documentViewModel)
                .environmentObject(dataController)
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
        //wird beim aktivieren der App ausgeführt
        .onChange(of: scenePhase) { phase in
            if phase == .active {
            }
        }
    }
}
