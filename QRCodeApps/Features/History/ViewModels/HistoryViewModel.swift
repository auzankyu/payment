//
//  HistoryViewModel.swift
//  QRCodeApps
//
//  Created by Auzan Lazuardi on 31/01/24.
//

import Foundation
import RxSwift
import RxCocoa

class HistoryViewModel {
    
    var transactions = PublishRelay<[HistoryTransaction]>()
    
    init() {
        
    }
    
    func getAllTransaction(completion: @escaping ((Bool) -> Void)) {
        //get data transaction from local
        guard let historyTransactions = UserDefaults.standard.array(forKey: "transactions") as? [Data] else {
            completion(true)
            return
        }
        
        var allTransaction = historyTransactions.compactMap { transaction in
            return try? JSONDecoder().decode(HistoryTransaction.self, from: transaction)

        }
        
        //display in descending order
        allTransaction.reverse()
        transactions.accept(allTransaction)
        completion(false)
    }
}
