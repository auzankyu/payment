//
//  UtilsManager.swift
//  QRCodeApps
//
//  Created by Auzan Lazuardi on 30/01/24.
//

import Foundation

class UtilsManager {
    static let shared = UtilsManager()
    
    func formatNumber(value: Int) -> String {
        let number = NumberFormatter()
        number.numberStyle = .decimal
        number.groupingSeparator = "."
        let formattedNumber = number.string(from: NSNumber(value: value))
        return formattedNumber!
    }
}
