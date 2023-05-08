//
//  OwnDocumentView.swift
//  Sicherheitsberater
//
//  Created by Benjamin Grunow on 02.05.23.
//

import SwiftUI

struct OwnDocumentView: View {
    
    @State private var showUploadSheet: Bool = false
    @State private var presentImporter: Bool = false
    @EnvironmentObject var documentViewModel: DocumentViewModel
    var docName: String
    
    var body: some View {
        
        Group {
            //Check if document was uploaded
            if (documentViewModel.checkForOwnFile(type: docName)) {
                VStack {
                    NavigationLink {
                        PDFUIView(documents: docName)
                    } label: {
                        VStack {
                            Image(systemName: "doc")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                            .frame(height: 40)
                            Text("Eigenes Dokument")
                        }
                    }
                }
            } else {
                VStack {
                    Button {
                        showUploadSheet.toggle()
                    } label: {
                        VStack {
                            Image(systemName: "doc.badge.arrow.up")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 40)
                            Text("Dokument einfügen")
                        }
                    }
                }
            }
        }
        
        .fileImporter(isPresented: $presentImporter, allowedContentTypes: [.pdf]) { result in
            switch result {
                case
                    .success(let selectedFile):
                print(selectedFile)
                if selectedFile.startAccessingSecurityScopedResource() {
                    FileManager.default.uploadFile(pickedURL: selectedFile, fileName: docName, fileExtension: ".pdf")
                    print("File uploaded")
                    selectedFile.stopAccessingSecurityScopedResource()
                    //documentViewModel.hasNetzplan.toggle()
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
                ])
        }
        
        
        
    }
}

struct OwnDocumentView_Previews: PreviewProvider {
    static var previews: some View {
        OwnDocumentView(docName: "netzplan")
            .environmentObject(DocumentViewModel())
    }
}
