//
//  NetworkManager.swift
//  KOKO
//
//  Created by David Shiue on 2025/10/16.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    func fetchJSONStringAsyncAwait(from urlString: String) async throws -> String {
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        guard let jsonString = String(data: data, encoding: .utf8) else {
            throw URLError(.cannotDecodeContentData)
        }
        
        return jsonString
    }
}

