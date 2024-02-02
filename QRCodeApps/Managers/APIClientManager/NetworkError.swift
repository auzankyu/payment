//
//  NetworkError.swift
//  QRCodeApps
//
//  Created by Auzan Lazuardi on 30/01/24.
//

import Foundation

enum NetworkError: Error {
    case failedToGetJSON
    case decodingError
}
