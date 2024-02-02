//
//  Transaction.swift
//  QRCodeApps
//
//  Created by Auzan Lazuardi on 31/01/24.
//

import Foundation

struct Transaction: Codable {
    let bankName: String
    let idTransaction: String
    let merchantName: String
    let totalAmount: Int
}
