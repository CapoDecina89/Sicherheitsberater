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
            DisclosureGroup(/*@START_MENU_TOKEN@*/"Group"/*@END_MENU_TOKEN@*/) {
                /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Content@*/Text("Content")/*@END_MENU_TOKEN@*/
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
