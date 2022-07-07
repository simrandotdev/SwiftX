//
//  LocalStorageManager.swift
//  Podcasts App
//
//  Created by Simran Preet Narang on 2021-12-22.
//  Copyright © 2021 Simran App. All rights reserved.
//

import Foundation

enum LocalStorageError: Error {
    case failedToEncode(errorMessage: String, friendlyMessage: String)
    case failedToDecode(errorMessage: String, friendlyMessage: String)
    case invalidKey(errorMessage: String, friendlyMessage: String)
}

struct LocalStorageManager {
    private let storage = UserDefaults.standard
    
    func save<T: Codable>(_ data: T, forKey key: String) throws {
        let encoder = JSONEncoder()
        do {
            let encodedData = try encoder.encode(data)
            storage.set(encodedData, forKey: key)
        } catch {
            throw LocalStorageError.failedToEncode(errorMessage: "❌ Failed to save due to encoding error: \(error.localizedDescription) for key: \(key)",
                                                   friendlyMessage: "Could save information. Please try again" )
        }
    }
    
    func load<T: Codable>(fromKey key: String) throws -> T {
        let decoder = JSONDecoder()
        do {
            guard let encodedData = storage.data(forKey: key) else {
                throw LocalStorageError.invalidKey(errorMessage: "❌ No data found for key: \(key)",
                                                   friendlyMessage: "No data found.")
            }
            return try decoder.decode(T.self, from: encodedData)
        } catch {
            throw LocalStorageError.failedToDecode(errorMessage: "❌ Failed to retrieve due to decoding error: \(error.localizedDescription) for key: \(key)",
                                                   friendlyMessage: "Could load information. Please try again" )
        }
    }
}
