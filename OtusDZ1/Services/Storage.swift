//
//  Storage.swift
//  OtusDZ1
//
//  Created by Генрих Берайлик on 30/08/2019.
//  Copyright © 2019 Генрих Берайлик. All rights reserved.
//

import Foundation

class Storage {
    
    enum Directory {
        case documents
        case caches
    }
    
    func store<T: Encodable>(_ object: T, to directory: Directory, as fileName: String) {
        let url = getURL(for: directory).appendingPathComponent(fileName, isDirectory: false)
        
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(object)
            if FileManager.default.fileExists(atPath: url.path) {
                try FileManager.default.removeItem(at: url)
            }
            FileManager.default.createFile(atPath: url.path, contents: data, attributes: nil)
        } catch {
            fatalError("Cannot store file")
        }
    }
    
    func retrieve<T: Decodable>(_ fileName: String, from directory: Directory, as type: T.Type) -> T? {
        let url = getURL(for: directory).appendingPathComponent(fileName, isDirectory: false)
        
        guard FileManager.default.fileExists(atPath: url.path) else {
            print("File doesn't exist")
            return nil
        }
        
        if let data = FileManager.default.contents(atPath: url.path) {
            let decoder = JSONDecoder()
            do {
                let model = try decoder.decode(type, from: data)
                return model
            } catch {
                print(error.localizedDescription)
            }
        } else {
            print("No data at \(url.path)")
        }
        return nil
    }
    
    private func getURL(for directory: Directory) -> URL {
        var searchDirectory: FileManager.SearchPathDirectory
        
        switch directory {
        case .documents:
            searchDirectory = .documentDirectory
        case .caches:
            searchDirectory = .cachesDirectory
        }
        
        guard let url = FileManager.default.urls(for: searchDirectory, in: .userDomainMask).first else {
            fatalError("Could npot create documents folder")
        }
        return url
    }
    
}
