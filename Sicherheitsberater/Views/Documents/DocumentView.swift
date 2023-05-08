//
//  DocumentationView.swift
//  Sicherheitsberater
//
//  Created by Benjamin Grunow on 21.04.23.
//

import SwiftUI

struct DocumentView: View {
    
    @EnvironmentObject var documentViewModel: DocumentViewModel
    
    
    var body: some View {
        NavigationStack{
            Group {
                GroupBox {
                    HStack {
                        VStack {
                            ExampleDocumentView(docName: "netzplanBeispiel")
                        }
                        Spacer()
                        OwnDocumentView(docName: "netzplan")
                    }
                    .padding(.top)
                } label: {
                    Text("Netzwerkplan der Praxis")
                }
                
                GroupBox {
                    HStack {
                        VStack {
                            ExampleDocumentView(docName: "rollenmatrixBeispiel")
                        }
                        Spacer()
                        OwnDocumentView(docName: "rollenmatrix")
                    }
                    .padding(.top)
                } label: {
                    Text("Rollenmatrix für Berechtigungen")
                }
                
                GroupBox {
                    HStack {
                        VStack {
                            ExampleDocumentView(docName: "notfallplanBeispiel")
                        }
                        Spacer()
                        OwnDocumentView(docName: "notfallplan")
                    }
                    .padding(.top)
                } label: {
                    Text("Notfallplanung (empfohlen)")
                }
                Spacer()
            }
            .padding()
            .navigationTitle("Dokumentation")
        }
    }
}
struct DocumentationView_Previews: PreviewProvider {
    static var previews: some View {
        DocumentView()
            .environmentObject(DocumentViewModel())
    }
}


