//
//  DashboardView.swift
//  Sicherheitsberater
//
//  Created by Benjamin Grunow on 11.04.23.
//

import SwiftUI

struct DashboardView: View {

    var body: some View {
        NavigationStack {
            FilteredList()
            .navigationTitle("Übersicht")
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
            .environmentObject(RequirementData())
            .environmentObject(ProfileViewModel())
    }
}
