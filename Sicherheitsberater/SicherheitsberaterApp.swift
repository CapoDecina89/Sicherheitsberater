//
//  SicherheitsberaterApp.swift
//  Sicherheitsberater
//
//  Created by Benjamin Grunow on 08.04.23.
//

import SwiftUI

@main
struct SicherheitsberaterApp: App {
    
    @StateObject var requirementData: RequirementData = RequirementData()
    @StateObject var profileViewModel: ProfileViewModel = ProfileViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(requirementData)
                .environmentObject(profileViewModel)
        }
    }
}
