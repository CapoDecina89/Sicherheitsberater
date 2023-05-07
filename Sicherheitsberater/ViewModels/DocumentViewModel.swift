//
//  DocumentViewModel.swift
//  Sicherheitsberater
//
//  Created by Benjamin Grunow on 07.05.23.
//

import Foundation

class DocumentViewModel: ObservableObject {
    
    @Published var hasNetzplan: Bool = false
    @Published var hasRollenmatrix: Bool = false
    
    init() {
        hasNetzplan = checkForOwnFile(type: "netzplan")
        hasRollenmatrix = checkForOwnFile(type: "rollenmatrix")
    }
    
    func updateStatus() {
        hasNetzplan = checkForOwnFile(type: "netzplan")
        hasRollenmatrix = checkForOwnFile(type: "rollenmatrix")
    }
    
    func checkForOwnFile(type: String) -> Bool {
        let directoryURL = FileManager.default.getDocumentsDirectory()
        let fileURL = URL(fileURLWithPath: type, relativeTo: directoryURL).appendingPathExtension("pdf")
        return fileURL.checkFileExist()
    }
}
