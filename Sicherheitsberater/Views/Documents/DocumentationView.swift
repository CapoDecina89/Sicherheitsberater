//
//  DocumentationView.swift
//  Sicherheitsberater
//
//  Created by Benjamin Grunow on 21.04.23.
//

import SwiftUI

struct DocumentationView: View {
    
    @State private var showUploadSheet: Bool = false
    @State private var presentImporter: Bool = false
    @EnvironmentObject var documentViewModel: DocumentViewModel
    
    
    var body: some View {
        NavigationStack{
            GroupBox {
                HStack {
                    VStack {
                        ExampleDocumentView(docName: "netzplanBeispiel")
                        Text("Vorlage Netzwerkplan")
                    }
                    Spacer()
                    //Check if document was uploaded
                    if (documentViewModel.hasNetzplan == true) {
                        VStack {
                            OwnDocumentView(docName: "netzplan")
                            
                        }
                    } else {
                        VStack {
                            Button {
                                showUploadSheet.toggle()
                            } label: {
                                Image(systemName: "doc.badge.arrow.up")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 40)
                            }
                            Text("Dokument einfügen")
                        }
                    }
                }
                .padding(.top)
            } label: {
                Text("Netzwerkplan der Praxis")
            }
            
            GroupBox {
                HStack {
                    VStack {
                        ExampleDocumentView(docName: "rollenmatrixBeispiel")
                        Text("Vorlage Rollenmatrix")
                    }
                    Spacer()
                    //Check if document was uploaded
                    if (documentViewModel.hasRollenmatrix == true) {
                        VStack {
                            OwnDocumentView(docName: "rollenmatrix")
                            Text("aktuelle Matrix")
                        }
                    } else {
                        VStack {
                            Button {
                                showUploadSheet.toggle()
                            } label: {
                                Image(systemName: "doc.badge.arrow.up")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 40)
                            }
                            Text("Dokument einfügen")
                        }
                    }
                }
                .padding(.top)
            } label: {
                Text("Rollenmatrix für Berechtigungen")
            }
            
            
            
        }
            .padding()
            .navigationTitle("Dokumentation")
        
        .fileImporter(isPresented: $presentImporter, allowedContentTypes: [.pdf]) { result in
            switch result {
                case
                    .success(let selectedFile):
                print(selectedFile)
                if selectedFile.startAccessingSecurityScopedResource() {
                    FileManager.default.uploadFile(pickedURL: selectedFile, fileName: "netzplan", fileExtension: ".pdf")
                    print("File uploaded")
                    selectedFile.stopAccessingSecurityScopedResource()
                    documentViewModel.hasNetzplan.toggle()
                } else {
                    return
                }
            case .failure(let error):
                    print("unable to read file")
                    print(error.localizedDescription)
                }
        }
                    
    
        .actionSheet(isPresented: $showUploadSheet) {
            ActionSheet(
                title: Text("Dokument in die App hochladen"),
                buttons:[
                    .default(Text("Datei auswählen"), action: {
                        presentImporter.toggle()
                    }),
                    .default(Text("Foto aufnehmen")),
                    .cancel()
                ]
            )}
    }
}
struct DocumentationView_Previews: PreviewProvider {
    static var previews: some View {
        DocumentationView()
    }
}


