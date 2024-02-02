//
//  CButton.swift
//  QRCodeApps
//
//  Created by Auzan Lazuardi on 30/01/24.
//

import UIKit

class CButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.fromHex(hex: "#130f40")
        layer.cornerRadius = 8
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

}
