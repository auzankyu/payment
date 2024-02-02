//
//  QRCodeModule.swift
//  QRCodeApps
//
//  Created by Auzan Lazuardi on 31/01/24.
//

import UIKit

protocol QRCodeModuleProtocol {
    func transactionScreen(with viewModel: TransactionViewModel) -> UIViewController
}

class QRCodeModule: QRCodeModuleProtocol {
    func transactionScreen(with viewModel: TransactionViewModel) -> UIViewController {
        let vc = TransactionViewController(with: viewModel)
        vc.hidesBottomBarWhenPushed = true
        return vc
    }
}
