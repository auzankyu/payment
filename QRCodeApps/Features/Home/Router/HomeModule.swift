//
//  HomeModule.swift
//  QRCodeApps
//
//  Created by Auzan Lazuardi on 31/01/24.
//

import UIKit

protocol HomeModuleProtocol {
    func qrcodeScreen() -> UIViewController
}

class HomeModule: HomeModuleProtocol {
    func qrcodeScreen() -> UIViewController {
        let vc = QRCodeViewController()
        vc.hidesBottomBarWhenPushed = true
        return vc
    }
}
