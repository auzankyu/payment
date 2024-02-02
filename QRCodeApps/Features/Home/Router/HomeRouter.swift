//
//  HomeRouter.swift
//  QRCodeApps
//
//  Created by Auzan Lazuardi on 31/01/24.
//

import UIKit

protocol HomeRouterProtocol {
    func routeToScanner(viewController: UIViewController)
}

class HomeRouter: HomeRouterProtocol {
    @Injectable(.singleton) var module: HomeModuleProtocol
    static let shared = HomeRouter()
    
    func routeToScanner(viewController: UIViewController) {
        let screen = module.qrcodeScreen()
        viewController.navigationController?.pushViewController(screen, animated: true)
    }
}
