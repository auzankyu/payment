//
//  QRCodeRouter.swift
//  QRCodeApps
//
//  Created by Auzan Lazuardi on 31/01/24.
//

import UIKit

protocol QRCodeRouterProtocol {
    func routeToTransaction(viewController: UIViewController, with viewModel: TransactionViewModel)
}

class QRCodeRouter: QRCodeRouterProtocol {
    @Injectable(.singleton) var module: QRCodeModuleProtocol
    static let shared = QRCodeRouter()
    
    func routeToTransaction(viewController: UIViewController, with viewModel: TransactionViewModel) {
        let screen = module.transactionScreen(with: viewModel)
        viewController.navigationController?.pushViewController(screen, animated: true)
    }
}

