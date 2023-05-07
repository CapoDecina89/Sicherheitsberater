//
//  OwnDocumentView.swift
//  Sicherheitsberater
//
//  Created by Benjamin Grunow on 02.05.23.
//

import SwiftUI

struct OwnDocumentView: View {
    
    var docName: String
    
    var body: some View {
        NavigationLink {
            PDFUIView(documents: docName)
        } label: {
            Image(systemName: "doc")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 40)
        }
    }
}

struct OwnDocumentView_Previews: PreviewProvider {
    static var previews: some View {
        OwnDocumentView(docName: "netzplan")
    }
}
