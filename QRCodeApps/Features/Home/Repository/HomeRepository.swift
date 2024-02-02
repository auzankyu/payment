//
//  HomeRepository.swift
//  QRCodeApps
//
//  Created by Auzan Lazuardi on 30/01/24.
//

import Foundation

protocol HomeRepositoryProtocol {
    func getUserProfile() async throws -> Profile
    func getChart() async throws -> [ChartType]
}

class HomeRepository: HomeRepositoryProtocol {
    @Injectable(.singleton) var apiClient: APIClient
    
    func getUserProfile() async throws -> Profile {
        let endpoint = HomeEndpoint.getProfile
        
        do {
            return try await apiClient.get(with: endpoint, using: Profile.self)
        } catch {
            throw NetworkError.decodingError
        }
    }
    
    func getChart() async throws -> [ChartType] {
        let endpoint = HomeEndpoint.getChart
        
        do {
            return try await apiClient.get(with: endpoint, using: [ChartType].self)
        } catch {
            throw NetworkError.decodingError
        }
    }
    
}
