//
//  QRCodeViewModel.swift
//  QRCodeApps
//
//  Created by Auzan Lazuardi on 31/01/24.
//

import RxSwift

class QRCodeViewModel {
    
    init() {
        
    }
    
    public func dataProcced(with data: String, completion: @escaping (Transaction) -> Void) {
        let component = data.split(separator: ".")
        
        let bankName = component[0]
        let idTransaction = component[1]
        let merchantName = component[2]
        let totalAmount = component[3]
        
        let newTransaction: Transaction = .init(
            bankName: String(bankName),
            idTransaction: String(idTransaction),
            merchantName: String(merchantName),
            totalAmount: Int(String(totalAmount))!
        )
        
        completion(newTransaction)
    }
    
    public func routeToTransaction(from viewController: UIViewController, with viewModel: TransactionViewModel) {
        QRCodeRouter.shared.routeToTransaction(viewController: viewController, with: viewModel)
    }
}
