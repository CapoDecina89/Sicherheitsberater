//
//  DocumentationView.swift
//  Sicherheitsberater
//
//  Created by Benjamin Grunow on 21.04.23.
//

import SwiftUI

struct DocumentationView: View {
    var body: some View {
        NavigationStack{
            Grid {
                GridRow {
                    ExampleDocumentView()
                    ExampleDocumentView()
                }
                GridRow {
                    ExampleDocumentView()
                    ExampleDocumentView()
                }
            }
                .navigationTitle("Dokumentation")
        }
    }
}

struct DocumentationView_Previews: PreviewProvider {
    static var previews: some View {
        DocumentationView()
    }
}
