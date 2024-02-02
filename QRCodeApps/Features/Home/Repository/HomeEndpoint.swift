//
//  HomeEndpoint.swift
//  QRCodeApps
//
//  Created by Auzan Lazuardi on 30/01/24.
//

import Foundation

enum HomeEndpoint: Endpoint {
    case getProfile
    case getChart
    
    var mockJsonFile: String? {
        switch self {
        case .getProfile:
            return "profileResponse"
        case .getChart:
            return "chartResponse"
        }
    }
}
