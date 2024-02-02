//
//  MockAPIClient.swift
//  QRCodeApps
//
//  Created by Auzan Lazuardi on 30/01/24.
//

import Foundation

protocol MockAPIClient: AnyObject {
    var bundle: Bundle { get }
    func loadJSON<T: Decodable>(filename: String, type: T.Type) -> T
}

extension MockAPIClient {
    var bundle: Bundle {
        return Bundle(for: type(of: self))
    }

    func loadJSON<T: Decodable>(filename: String, type: T.Type) -> T {
        guard let path = bundle.url(forResource: filename, withExtension: "json") else {
            fatalError("Failed to load JSON")
        }

        do {
            let data = try Data(contentsOf: path)

            let decodedObject = try JSONDecoder().decode(T.self, from: data)
            return decodedObject
        } catch {
            fatalError("Failed to decode loaded JSON")
        }
    }
}
