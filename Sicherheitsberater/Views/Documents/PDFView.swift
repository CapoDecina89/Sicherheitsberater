//
//  PDFView.swift
//  Sicherheitsberater
//
//  Created by Benjamin Grunow on 02.05.23.
//

import SwiftUI
import PDFKit



struct PDFUIView: View {

    @State private var isShowingDialog = false
    @EnvironmentObject var documentViewModel: DocumentViewModel
    @Environment(\.dismiss) var dismiss
    let pdfDoc: PDFDocument
    let pdfURL: URL?

    init(bundled pdfName: String) {
        let url = Bundle.main.url(forResource: pdfName, withExtension: "pdf")!
        pdfDoc = PDFDocument(url: url)!
        pdfURL = nil
    }
    
    init(documents pdfName: String) {
        let directoryURL = FileManager.default.getDocumentsDirectory()
        let fileURL = URL(fileURLWithPath: pdfName, relativeTo: directoryURL).appendingPathExtension("pdf")
        pdfDoc = PDFDocument(url: fileURL)!
        pdfURL = fileURL
    }

    var body: some View {
        //Menu only shows, for own documents
        if (pdfURL != nil) {
            PDFKitView(showing: pdfDoc)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Menu {
                            Button("Dokument löschen", role: .destructive) {
                                isShowingDialog = true
                            }
                        } label: {
                            Image(systemName: "ellipsis.circle")
                        }
                    }
                }
                .confirmationDialog(Text("Wollen Sie das Dokument wirklich löschen?"), isPresented: $isShowingDialog) {
                    Button("Dokument löschen", role: .destructive) {
                        do {
                            try FileManager.default.removeItem(at: pdfURL!)
                            documentViewModel.updateStatus()
                        } catch {
                            print("Löschen des Dokuments ist fehlgeschlagen")
                        }
                        
                        dismiss()
                    }
                } message: {
                    Text("Diesen Vorgang können Sie nicht rückgängig machen.")
                }
        } else {
            PDFKitView(showing: pdfDoc)
        }
    }
}

struct PDFView_Previews: PreviewProvider {
    static var previews: some View {
        PDFUIView(bundled: "netzplanBeispiel")
    }
}

struct PDFKitView: UIViewRepresentable {

    let pdfDocument: PDFDocument

    init(showing pdfDoc: PDFDocument) {
        self.pdfDocument = pdfDoc
    }

    //you could also have inits that take a URL or Data

    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.document = pdfDocument
        pdfView.autoScales = true
        return pdfView
    }

    func updateUIView(_ pdfView: PDFView, context: Context) {
        pdfView.document = pdfDocument
    }
}
