//
//  DetailView.swift
//  Sicherheitsberater
//
//  Created by Benjamin Grunow on 21.04.23.
//

import SwiftUI
import CoreData

struct DetailView: View {
    @EnvironmentObject var dataController: DataController
    var requirement: RequirementEntity
    
    var body: some View {
        Form {
            LabeledContent("ID", value: requirement.id ?? "")
            LabeledContent("Anforderung", value: requirement.name ?? "")
            LabeledContent("Status geändert", value: requirement.changingDate?.formatted(date: .numeric, time: .shortened) ?? "")
            Section {
                Text(requirement.explanation ?? "")
            } header: {
                Text("Erklärung")
            }
        }
        .navigationTitle("Details")
    }
}

struct DetailView_Previews: PreviewProvider {
    
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        let requirement = RequirementEntity(context: moc)
        requirement.id = "A1-1"
        requirement.objectType = "Mobile Anwendungen (Apps)"
        requirement.name = "Sichere Apps nutzen"
        requirement.explanation = "Nur Apps aus den offiziellen Stores runterladen und nutzen. Wenn nicht mehr benötigt, Apps restlos löschen."
        requirement.sizeCategory = "all"
        requirement.changingDate = Date()
        
        return NavigationStack {
            DetailView(requirement: requirement)
                .navigationTitle("Details")
        }
    }
}
