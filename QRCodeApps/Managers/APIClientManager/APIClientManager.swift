//
//  APIClientManager.swift
//  QRCodeApps
//
//  Created by Auzan Lazuardi on 30/01/24.
//

import Foundation

protocol APIClient {
    func get<T: Decodable>(with endpoint: Endpoint, using model: T.Type) async throws -> T
}

class APIClientManager: MockAPIClient, APIClient {
    func get<T>(with endpoint: Endpoint, using model: T.Type) async throws -> T where T : Decodable {
        guard let endpoint = endpoint.mockJsonFile else {
            throw NetworkError.failedToGetJSON
        }
        
        return loadJSON(filename: endpoint, type: model)
    }
}
