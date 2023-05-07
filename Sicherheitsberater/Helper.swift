//
//  Helper.swift
//  Sicherheitsberater
//
//  Created by Benjamin Grunow on 22.04.23.
//

import Foundation

extension Bundle {
    func decode<T: Decodable>(_ type: T.Type, from file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }

        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.")
        }

        return loaded
    }
}
//function to deduplicate Arrays
public extension Array where Element: Hashable {
    func uniqued() -> [Element] {
        var seen = Set<Element>()
        return filter { seen.insert($0).inserted }
    }
}

extension FileManager {
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    func uploadFile(pickedURL:URL, fileName:String, fileExtension: String) {
        let documentsURL = getDocumentsDirectory().appendingPathComponent(fileName + fileExtension )
        print(documentsURL)
        do{
            try FileManager.default.copyItem(at: pickedURL, to: documentsURL)
        } catch {
            print("copy error")
        }
    }
    
    func deleteFile(fileName: String, fileExtension: String) {
        let documentsURL = getDocumentsDirectory().appendingPathComponent(fileName + fileExtension )
        do {
            try FileManager.default.removeItem(at: documentsURL)
        } catch {
            print("Löschen war nicht möglich")
        }
        
    }
}

extension URL    {
    func checkFileExist() -> Bool {
        let path = self.path
        if (FileManager.default.fileExists(atPath: path))   {
            print("FILE AVAILABLE")
            return true
        }else        {
            print("FILE NOT AVAILABLE")
            return false;
        }
    }
}
