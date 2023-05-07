//
//  ExampleDocumentView.swift
//  Sicherheitsberater
//
//  Created by Benjamin Grunow on 29.04.23.
//

import SwiftUI

struct ExampleDocumentView: View {
    var docName: String
    var body: some View {
        NavigationLink {
            PDFUIView(bundled: docName)
        } label: {
            Image(systemName: "doc.richtext")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 40)
        }

    }
}

struct ExampleDocumentView_Previews: PreviewProvider {
    static var previews: some View {
        ExampleDocumentView(docName: "netzplanBeispiel")
    }
}
